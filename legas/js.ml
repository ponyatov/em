let package () =
  touch "package.json" ~c:"" ();
  Sys.command "git add *.json"|> ignore

let js () =
  package();
  Sys.command "cp ~/em/.prettierrc ./" |> ignore;
  Sys.command "git add .clang-format "|> ignore
