/-  docket
/+  *globber, default-agent, dbug
=*  card  card:agent:gall
%-  agent:dbug
^-  agent:gall
|_  =bowl:gall
+*  this      .
    def   ~(. (default-agent this %|) bowl)
::
++  on-save  on-save:def
++  on-load  on-load:def
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-agent  on-agent:def
++  on-fail   on-fail:def
++  on-init
  ^-  (quip card _this)
  :_  this
  :: bind to /globber
  :~  [%pass /bind-globber %arvo %e %connect `/'globber' %globber]
  ==
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?+    mark  (on-poke:def mark vase)
      %handle-http-request
    =+  !<([id=@ta req=inbound-request:eyre] vase)
    ::  handle request
    [(handle-http-request our.bowl id req) this]
  ==
::
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?+    path  (on-watch:def path)
      [%http-response *]
    %-  (slog leaf+"Eyre subscribed to {(spud path)}." ~)  `this
  ==
::
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?.  ?=([%bind-globber ~] wire)  (on-arvo:def [wire sign-arvo])
  ?>  ?=([%eyre %bound *] sign-arvo)
  ?:  accepted.sign-arvo
    %-  (slog leaf+"/globber bound successfully!" ~)  `this
  %-  (slog leaf+"Binding /globber failed!" ~)  `this
--
