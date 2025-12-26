
let doc () =
  mkd "doc" ~c:"html/\n!.gitignore\n" ();
  Sys.command "cp ~/icons/control_64x64.png doc/logo.png"|>ignore;
  Sys.command "cp ~/em/doc/ai.md doc/"|>ignore;
  Sys.command "git add doc"|>ignore
