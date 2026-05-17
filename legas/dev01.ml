let user = "dponyatov"
let devuser = "dimon"
let devserver = "10.110.1.101"

let dev01 () =
  (* *)
  let ssh = [%string "ssh %{devuser}@%{devserver}"] in
  Sys.command [%string "%{ssh} git clone -o gh -b %{user} %{github} ~/%{app}"];
  Sys.command
    [%string "%{ssh} \"(cd ~/%{app} && git remote add flic %{gitflic})\""]
