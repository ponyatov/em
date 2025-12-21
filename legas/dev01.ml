let user = "dponyatov";;
let devserver = "10.110.1.106";;
let devuser = "dev01";;

let dev01 () =
  Sys.command ("ssh "^devuser^"@"^devserver^" mkdir "^app)
