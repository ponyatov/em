
let doc () =
  mkd "doc" ~c:"html/\n!.gitignore\n" ();
  Sys.command "cp ~/icons/control_64x64.png doc/logo.png"|>ignore;
  Sys.command "cp ~/em/doc/ai.md doc/"|>ignore;
  touch "doc/bib.md" ();
  mkd ("../metadoc/"^app) ();
  Sys.command ("cp ../metadoc/"^app^"/bib.md doc/bib.md")|>ignore;
  Sys.command ("cp README.md ../metadoc/"^app^"/"^app^".md");
  Sys.command "git add doc"|>ignore;
