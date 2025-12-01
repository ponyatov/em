open Unix

let touch name ?(c = "") () =
  (* if not (Sys.file_exists name) then *)
  let f = open_out name in
  output_string f c;
  close_out f

let mkd name ?(c = "!.gitignore\n") () =
  if not (Sys.file_exists name) then Sys.mkdir name 0o755;
  touch (Filename.concat name ".gitignore") ~c ()

let dirs () =
  [ ".vscode"; "lib"; "inc"; "src" ] |> List.iter (fun d -> mkd d ())

let bins () =
  [ "bin"; "tmp"; "ref" ] |> List.iter (fun d -> mkd d ~c:"*\n!.gitignore\n" ())

let giti () =
  touch ".gitignore" ~c:"*~
*.swp
*.log
/_build/
/target/
!.gitignore
" ()
