
let doc () =
  mkd "doc" ~c:"html/\n!.gitignore\n" ();
  Sys.command "cp ~/icons/control_64x64.png doc/logo.png"|>ignore;
  Sys.command "cp ~/em/doc/ai.md doc/"|>ignore;
  touch "doc/bib.md" ~c:"# bib\n" ();
  mkd [%string "../metadoc/%{app}"] ();
  Sys.command [%string "cp ../metadoc/%{app}/bib.md doc/bib.md"]|>ignore;
  Sys.command [%string "cp README.md ../metadoc/%{app}/%{app}.md"]|>ignore;
  Sys.command [%string "cp doc/bib.md ../metadoc/%{app}/bib.md"]|>ignore
