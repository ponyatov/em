(* open Unix *)

let touch name ?(c = "") () =
  (* if not (Sys.file_exists name) then *)
  let f = open_out name in
  output_string f c;
  close_out f

let append name ?(c = "") () =
  let f = open_out_gen [ Open_append ] 0o644 name in
  output_string f c;
  close_out f

let mkd name ?(c = "!.gitignore\n") () =
  if not (Sys.file_exists name) then Sys.mkdir name 0o755;
  touch (Filename.concat name ".gitignore") ~c ()

let dirs () =
  [ ".vscode"; "lib"; "inc"; "src" ] |> List.iter (fun d -> mkd d ());
  [ "doc" ] |> List.iter (fun d -> mkd d ~c:"html/\n!.gitignore\n" ());
  [ "bin"; "tmp"; "ref" ] |> List.iter (fun d -> mkd d ~c:"*\n!.gitignore\n" ())

let giti () =
  touch ".gitignore" ~c:"*~
*.swp
*.log
/_build/
!.gitignore
" ();
  Sys.command "git add .gitignore" |> ignore

let apt () =
  let a = "git make curl fzf\n" in
  touch "apt.Debian" ~c:[%string "%{a}code meld\n"] ();
  touch "apt.Ubuntu" ~c:[%string "%{a}"] ();
  touch "apt.Raspbian" ~c:a ();
  Sys.command "git add apt.*" |> ignore

let readme () =
  touch "README.md"
    ~c:
      [%string
        "# ![](doc/logo.png) %{app} %{version}
## %{title}

(c) %{author} <<%{email}>> %{year#Int} %{license}

github: %{github}

%{about}"]
    ();
  Sys.command "git add README.md" |> ignore

let ini () =
  mkd "lib" ();
  touch ("lib/" ^ app ^ ".ini") ~c:"# line comment\n" ();
  Sys.command "git add lib" |> ignore

let dotfiles () =
  Sys.command "cp ~/em/.prettierrc ./" |> ignore;
  Sys.command "git add .prettierrc" |> ignore

let files () =
  dirs ();
  bins ();
  giti ();
  apt ();
  readme ();
  ini ();
  dotfiles ()
