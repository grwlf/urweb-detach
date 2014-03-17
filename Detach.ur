structure C = Callback.Make(
  struct
    val f = fn x => return (<xml>{[x.Stdout]}</xml> : xbody)
    val depth = 1000
    val stdout_sz = 1024
  end)

fun download {} : transaction page =
  s <- detachSocket;
  jr <- C.nextjob {};
  debug "detached";
  C.create jr ("./Serve.sh " ^ (show s)) (textBlob "");
  return <xml> <body> detached page </body> </xml>

fun main {} : transaction page = 
  return
    <xml>
      <body>
        Hello, detach
        <br/>
        <a link={download {}}>Download something</a>
      </body>
    </xml>

