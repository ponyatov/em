let touch name ?(c = "") () =
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

let ocaml () =
  touch ".ocamlinit"
    ~c:
      "#require \"ppx_string\";;
#use \"lib/files.ml\";;
#use \"lib/meta.ml\";;
"
    ();
  touch ".ocamlformat"
    ~c:
      "profile=default
margin=80
line-endings=lf
break-cases=all
wrap-comments=true
break-string-literals=never
"
    ()

let vscode () =
  mkd ".vscode" ();
  [ "settings"; "extensions"; "tasks"; "launch"; "c_cpp_properties" ]
  |> List.iter (fun j -> touch (".vscode/" ^ j ^ ".json") ~c:"{\n}\n" ())

let dotfiles () =
  Sys.command "cp ~/em/.prettierrc ./" |> ignore;

let giti () =
  touch ".gitignore" ~c:"\
*~
*.swp
*.log
!.gitignore
" ();

let apt () =
  let a = "git make curl fzf\n" in
  touch "apt.Debian" ~c:[%string "%{a}code meld\n"] ();
  touch "apt.Ubuntu" ~c:[%string "%{a}"] ();
  touch "apt.Raspbian" ~c:a ();
  Sys.command "git add apt.*" |> ignore

let readme () =
  mkd "doc" ~c:"html/\n!.gitignore\n" ();
  Sys.command "cp ~/icons/control_64x64.png doc/logo.png" |> ignore;
  touch "README.md"
    ~c:
      [%string
        "# ![](doc/logo.png) `%{app}` %{version}
## %{title}

(c) %{author} <<%{email}>> %{year#Int} %{license}

github: %{github}

%{about}"]
    ();
  Sys.command "git add README.md" |> ignore

let ini () =
  mkd "lib" ~c:"pcpp/\n!.gitignore\n" ();
  touch ("lib/" ^ app ^ ".ini") ~c:"# line comment\n" ();
  Sys.command "git add lib" |> ignore

let dotfiles () =
  Sys.command "cp ~/em/.prettierrc ./" |> ignore;
  Sys.command "git add .prettierrc" |> ignore

let files () =
  dirs ();
  ocaml ();
  vscode ();
  giti ();
  apt ();
  readme ();
  ini ();
  dotfiles ()
