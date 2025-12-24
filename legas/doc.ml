
let doc () =
  mkd "doc" ~c:"html/\n!.gitignore\n" ();
  Sys.command "cp ~/icons/control_64x64.png doc/logo.png";
  Sys.command "cp ~/em/doc/ai.md doc/";
  Sys.command "git add doc"
