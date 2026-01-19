let gh = [%string "git@github.com:ponyatov/%{app}.git"]
let flic = [%string "git@gitflic.ru:%{user}/%{String.lowercase_ascii app}.git"]

let git () =
  Sys.command "git init" |> ignore;
  Sys.command [%string "git remote add gh %{gh}"] |> ignore;
  Sys.command [%string "git remote add flic %{flic}" ]|> ignore;
  Sys.command [%string "git checkout --orphan %{user}" ]|> ignore;
  Sys.command [%string "git add -A ; git commit -am '.' ; git push -uv gh `whoami` "] |> ignore;
  Sys.command [%string "git add -A ; git commit -am '.' ; git push flic `whoami` "] |> ignore;
  (* *)
  Sys.command [%string "ssh %{devuser}@%{devserver} git clone -o gh %{gh} ~/%{app}"] |> ignore;
  Sys.command [%string "ssh %{devuser}@%{devserver} 'cd %{app} ; git remote add flic %{flic}'"] |> ignore
