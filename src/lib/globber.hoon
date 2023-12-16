/-  docket
/+  multipart
|%
+$  card  card:agent:gall
::
++  handle-http-request
  |=  [our=@p id=@ta req=inbound-request:eyre]
  ^-  (list card)
  =/  request=request:http  request.req
  ?.  =(method.request %'POST')  (reject-request id 'invalid method')
  (process-request our id request)
::
++  reject-request
  |=  [id=@ta reason=@t]
  ^-  (list card)
  =/  data=octs  (as-octs:mimes:html (crip :(weld "<h1>" (trip reason) "</h1>")))
  =/  content-length=@t      (crip ((d-co:co 1) p.data))
  =/  =response-header:http  [400 ~[['Content-Length' content-length] ['Content-Type' 'text/html']]]
  :~  
    [%give %fact [/http-response/[id]]~ %http-response-header !>(response-header)]
    [%give %fact [/http-response/[id]]~ %http-response-data !>(`data)]
    [%give %kick [/http-response/[id]]~ ~]
  ==
::
++  process-request
  |=  [our=@p id=@ta r=request:http] 
  ^-  (list card)
  ?~  parts=(de-request:multipart [header-list body]:r)
    (reject-request id 'empty request')
  =/  globbed=[glob:docket err=(list @t)]
    (roll u.parts convert-to-glob)
  =/  cards=(list card)  (print-errors id err.globbed)
  ?:  (gth 0 (lent cards))  cards  ::  return if error sent cards
  (return our id globbed)
::
++  convert-to-glob
  |=  [[name=@t part:multipart] =glob:docket err=(list @t)]
  ^+  [glob err]
  ::  all submitted files must be complete
  ::
  ?.  =('file' name)  [glob (cat 3 'weird part: ' name) err]
  ?~  file            [glob 'file without filename' err]
  ?~  type            [glob (cat 3 'file without type: ' u.file) err]
  ?^  code            [glob (cat 3 'strange encoding: ' u.code) err]
  =/  filp            (rush u.file fip)
  ?~  filp            [glob (cat 3 'strange filename: ' u.file) err]
  ::
  ?:  =('.DS_Store' (rear `path`u.filp))
    [glob err]
  ::  make sure to exclude the top-level dir from the path
  ::
  :_  err
  %+  ~(put by glob)  (slag 1 `path`u.filp)
  [u.type (as-octs:mimes:html body)]
::
++  fip
  =,  de-purl:html
  ;:  cook
    |=(pork (weld q (drop p)))
    deft
    |=(a=cord (rash a (more fas smeg))) 
    crip 
    (star ;~(pose (cold '%20' (just ' ')) next))
  ==
::
++  return  :: will eventually return glob
  |=  [our=@p id=@ta =glob:docket errors=(list @t)]
  =/  =path  /(cat 3 'glob-' (scot %uv (sham glob)))/glob
  ::~&  >  globbed+`(set ^path)`~(key by glob)
  ::~&  >>  errors
  ^-  (list card)
  =/  data=octs              (as-octs:mimes:html '<h1>success</h1>')  :: temp
  =/  content-length=@t      (crip ((d-co:co 1) p.data))
  =/  =response-header:http  [200 ~[['Content-Length' content-length] ['Content-Type' 'text/html']]]
  :~  
    [%pass /dumped %agent [our %hood] %poke %drum-put !>([path (jam glob)])]
    [%give %fact [/http-response/[id]]~ %http-response-header !>(response-header)]
    [%give %fact [/http-response/[id]]~ %http-response-data !>(`data)]
    [%give %kick [/http-response/[id]]~ ~]
  ==
::
++  print-errors
  |=  [id=@ta err=(list @t)]
  ^-  (list card)
  ?:  =(0 (lent err))  ~
  ?.  =((lent err) (lent (turn err print-error)))
    (reject-request id 'physically impossible error')
  ~
++  print-error
  |=  t=@t  ^-  @t
  ~&  >>  t 
  t
--
