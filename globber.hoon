/-  docket
/+  default-agent, dbug, multipart
=*  card  card:agent:gall
%-  agent:dbug
^-  agent:gall
|_  =bowl:gall
+*  this      .
    def   ~(. (default-agent this %|) bowl)
::
++  on-init  on-init:def
++  on-save  on-save:def
++  on-load
    |=  old-state=vase 
    %-  (slog leaf+"Attempting to bind /globber." ~)
    :_  this
    [%pass /bind-globber %arvo %e %connect `/'globber' %globber]~
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?+    mark
    (on-poke:def [mark vase])
  ::
      %handle-http-request
    =/  req  !<  (pair @ta inbound-request:eyre)  vase
    ?+    method.request.q.req
      =/  data=octs  (as-octs:mimes:html '<h1>405 Method Not Allowed</h1>')
      =/  content-length=@t  (crip ((d-co:co 1) p.data))
      =/  =response-header:http
        :-  405
        :~  ['Content-Length' content-length]
            ['Content-Type' 'text/html']
            ['Allow' 'POST']
        ==
      :_  this
      :~
        [%give %fact [/http-response/[p.req]]~ %http-response-header !>(response-header)]
        [%give %fact [/http-response/[p.req]]~ %http-response-data !>(`data)]
        [%give %kick [/http-response/[p.req]]~ ~]
      ==
    ::
        %'POST'
      ?~  parts=(de-request:multipart [header-list body]:request.q.req)
        =/  data=octs              (as-octs:mimes:html '<h1>Failed to parse directory</h1>')
        =/  content-length=@t      (crip ((d-co:co 1) p.data))
        =/  =response-header:http  [400 ~[['Content-Length' content-length] ['Content-Type' 'text/html']]]
        :_  this
        :~  
          [%give %fact [/http-response/[p.req]]~ %http-response-header !>(response-header)]
          [%give %fact [/http-response/[p.req]]~ %http-response-data !>(`data)]
          [%give %kick [/http-response/[p.req]]~ ~]
        ==
      =/  globbed=[glob:docket (list @t)]
      |^
      %+  roll  u.parts
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
      ++  fip
        =,  de-purl:html
        ;:  cook
          |=(pork (weld q (drop p)))
          deft
          |=(a=cord (rash a (more fas smeg))) 
          crip 
          (star ;~(pose (cold '%20' (just ' ')) next))
        ==
      --
      =/  =glob:docket  -:globbed
      =/  =path  /(cat 3 'glob-' (scot %uv (sham glob)))/glob
      ~&  >  globbed+`(set ^path)`~(key by glob)
      =/  data=octs  (as-octs:mimes:html '<h1>succeeded</h1>')
      =/  content-length=@t  (crip ((d-co:co 1) p.data))
      =/  =response-header:http  [200 ~[['Content-Length' content-length] ['Content-Type' 'text/html']]]
      :_  this
      :~
        [%pass /dumped %agent [our.bowl %hood] %poke %drum-put !>([path (jam glob)])]
        [%give %fact [/http-response/[p.req]]~ %http-response-header !>(response-header)]
        [%give %fact [/http-response/[p.req]]~ %http-response-data !>(`data)]
        [%give %kick [/http-response/[p.req]]~ ~]
      ==
    ==
  ==
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?+    path
    (on-watch:def path)
  ::
      [%http-response *]
    %-  (slog leaf+"Eyre subscribed to {(spud path)}." ~)
    `this
  ==
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-agent  on-agent:def
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?.  ?=([%bind-globber ~] wire)
    (on-arvo:def [wire sign-arvo])
  ?>  ?=([%eyre %bound *] sign-arvo)
  ?:  accepted.sign-arvo
    %-  (slog leaf+"/globber bound successfully!" ~)
    `this
  %-  (slog leaf+"Binding /globber failed!" ~)
  `this
++  on-fail   on-fail:def
--
