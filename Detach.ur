structure C = Callback.Default

fun download {} : transaction page =
  s <- detachSocket;
  j <- C.create (C.shellCommand ("./Serve.sh " ^ (show s)));
  return <xml><body>This is the detached page (will never be seen)</body></xml>

fun main {} : transaction page = 
  return
    <xml>
      <body>
        Hello, detach
        <br/>
        <a link={download {}}>Download something bulky</a>
      </body>
    </xml>

