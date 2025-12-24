let package () =
  touch "package.json" ~c:"" ();
  Sys.command "git add *.json"|> ignore

let aptjs () =
  append "apt.Ubuntu" ~c:"nodejs npm\n" ();

let js () =
  package();
  aptjs();
  Sys.command "cp ~/em/.prettierrc ./" |> ignore;
