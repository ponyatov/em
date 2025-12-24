(* open Unix *)

let touch name ?(c = "") () =
  (* if not (Sys.file_exists name) then *)
  let f = open_out name in
  output_string f c;
  close_out f

let append name ?(c = "") () =
  let f = open_out_gen [Open_append] 0o644 name in
  output_string f c;
  close_out f

let mkd name ?(c = "!.gitignore\n") () =
  if not (Sys.file_exists name) then Sys.mkdir name 0o755;
  touch (Filename.concat name ".gitignore") ~c ()

let dirs () =
  [ ".vscode"; "lib"; "src" ] |> List.iter (fun d -> mkd d ());
  Sys.command "git add .vscode lib src"|> ignore


let bins () =
  [ "bin"; "tmp"; "ref" ] |> List.iter (fun d -> mkd d ~c:"*\n!.gitignore\n" ());
  Sys.command "git add bin tmp ref"|> ignore


let giti () =
  touch ".gitignore" ~c:"*~
*.swp
*.log
/_build/
!.gitignore
" ();
    Sys.command "git add .gitignore"|> ignore

let apt () =
  let a = "git make curl fzf\n" in
  touch "apt.Debian" ~c:(a^"code meld\n") ();
  touch "apt.Ubuntu" ~c:a ();
  Sys.command "git add apt.*"|> ignore

let readme () =
  touch "README.md"
    ~c:
      ("# `" ^ app ^ "` " ^ version ^ "\n## " ^ title ^ "\n\n(c) " ^ author
     ^ " <<" ^ email ^ ">> " ^ Int.to_string year ^ " " ^ license ^ "\n\n"
     ^ github ^ "\n" ^ about)
    ();
  Sys.command "git add README.md"|> ignore

let ini() =
    mkd "lib" ();
    touch ("lib/"^app^".ini") ~c:"# line comment\n" ();
    Sys.command "git add lib"|> ignore

let dotfiles () =
  Sys.command "cp ~/em/.prettierrc ./" |> ignore;
  Sys.command "git add .prettierrc"|> ignore

let files () =
  dirs();
  bins();
  giti();
  apt();
  readme();
  ini();
  dotfiles()
