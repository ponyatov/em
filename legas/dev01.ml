let user = "dponyatov";;
let devserver = "10.110.1.101";;
let devuser = "dimon";;

let dev01 () =
  Sys.command ("ssh "^devuser^"@"^devserver^" mkdir "^app)
