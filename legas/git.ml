let git () = 
  Sys.command ("git init");
  Sys.command ("git remote add gh git@github.com:ponyatov/"^app^".git");
  Sys.command ("git remote add flic git@gitflic.ru:"^user^"/"^app^".git");
  Sys.command ("git checkout --orphan "^user);
  Sys.command ("git add -A ; git commit -am '.' ; git push -uv gh `whoami` ");
(* Sys.command ("git add -A ; git commit -am '.' ; git push -uv flic `whoami` "); *)
  
(* let gitref = "ref/" ^ tag *)

(* let git () =
  if not (Sys.file_exists (Filename.concat gitref "README.md")) then
    Sys.command
      ("git clone -o orig -b " ^ tag ^ " --depth 1 " ^ orig ^ " " ^ gitref)
    = 0
  else true *)
