let app = Sys.getcwd () |> String.split_on_char '/' |> List.rev |> List.hd
let title = "PcapPlusPlus"

let about =
  "
[PcapPlusPlus](https://pcapplusplus.github.io/) is a multiplatform C++ library
for capturing, parsing and crafting of network packets. It is designed to be
efficient, powerful and easy to use.
"

let author = "Dmitry Ponyatov"
let email = "dponyatov@gmail.com"
let year = 2025
let license = "MIT"
let github = "github: https://github.com/ponyatov/" ^ app
let orig = "https://github.com/seladb/PcapPlusPlus.git"
let tag = "v25.05"

let touch name ?(c = "") () =
  (* if not (Sys.file_exists name) then *)
  let f = open_out name in
  output_string f c;
  close_out f

let mkd name ?(c = "!.gitignore\n") () =
  if not (Sys.file_exists name) then Sys.mkdir name 0o755;
  touch (Filename.concat name ".gitignore") ~c ()

open Unix

let ocaml () =
  touch ".ocamlinit"
    ~c:"#use \"topfind\";;
#require \"unix\";;
(* #require \"ppx_string\";; *)
"
    ();

  let ic = Unix.open_process_in "ocamlformat --version" in
  let version = input_line ic in
  Unix.close_process_in ic |> ignore;

  touch ".ocamlformat"
    ~c:
      ("version=" ^ version
     ^ "
profile=default
margin=80
line-endings=lf
break-cases=all
wrap-comments=true
break-string-literals=never
# break-infix-before-func = false
# break-infix = fit-or-vertical
# break-separators = after
# let-and = sparse
"
      )
    ()

let dune () =
  touch "legas/dune"
    ~c:"(library
  (name legas)
  (modules dummy)
  (libraries ppx_string))
" ();
  let lang = "(lang dune           3.20)\n" in
  let name = "(name                " ^ app ^ ")\n" in
  let opam = "(generate_opam_files true)\n" in
  let authors = "(authors             \"" ^ author ^ " <" ^ email ^ ">\")\n" in
  let maintr = "(maintainers         \"" ^ author ^ " <" ^ email ^ ">\")\n" in
  let bugs = "(bug_reports         \"" ^ email ^ "\")\n" in
  let home = "(homepage            \"" ^ github ^ "\")\n" in
  let lic = "(license             \"" ^ license ^ "\")\n" in
  let src = "(source              (github ponyatov/" ^ app ^ "))\n" in
  let pack = "(package\n" in
  let syno = " (synopsis            \"" ^ title ^ "\")\n" in
  let about = "(description \"" ^ about ^ "\")\n" in
  let empty = "(allow_empty)\n" in
  touch "dune-project"
    ~c:
      (lang ^ name ^ opam ^ authors ^ maintr ^ bugs ^ home ^ lic ^ src ^ pack
     ^ " " ^ name ^ syno ^ about ^ empty ^ ")\n")
    ();
  Sys.command "dune build"

let dirs () =
  [ ".vscode"; "lib"; "inc"; "src" ] |> List.iter (fun d -> mkd d ())

let bins () =
  [ "bin"; "tmp"; "ref" ] |> List.iter (fun d -> mkd d ~c:"*\n!.gitignore\n" ())

let doc () =
  mkd "doc" ~c:"html/\n!.gitignore\n" ();
  Sys.command "doxygen -l";
  Sys.command "mv DoxygenLayout.xml doc/";
  Sys.command "cp ~/icons/control_64x64.png doc/logo.png"

let giti () =
  touch ".gitignore" ~c:"*~
*.swp
*.log
/_build/
/target/
!.gitignore
" ()

let mk () = touch "Makefile" ()

let apt () =
  touch "apt.Debian"
    ~c:
      "git make curl fzf
code meld doxygen
g++ cmake pkg-config clang-format
gdb gdbserver valgrind
flex bison ragel libreadline-dev
"
    ()

let readme () =
  (* *)
  touch "README.md"
    ~c:
      ("# `" ^ app ^ "` " ^ tag ^ "\n## " ^ title ^ "\n\n(c) " ^ author ^ " <<"
     ^ email ^ ">> " ^ Int.to_string year ^ " " ^ license ^ "\n\n" ^ github
     ^ "\n" ^ about)
    ()

let gitref = "ref/" ^ tag

let git () =
  if not (Sys.file_exists (Filename.concat gitref "README.md")) then
    Sys.command
      ("git clone -o orig -b " ^ tag ^ " --depth 1 " ^ orig ^ " " ^ gitref)
    = 0
  else true

let refdirs ?(p = Sys.is_directory) d =
  Sys.readdir d |> Array.to_list
  |> List.filter (fun f -> p (Filename.concat d f))
  |> List.filter (fun f ->
      not (List.mem f [ "."; ".."; ".git"; ".github"; ".vscode" ]))
;;

refdirs gitref |> List.iter (fun d -> mkd d ());;

let rfd ?(p = Sys.is_directory) r d =
  Sys.readdir (Filename.concat r d)
  |> Array.to_list
  |> List.filter (fun f -> p (r ^ '/' ^ d ^ '/' f))
  |> List.map (fun f -> Filename.concat d f)
;;

rfd "ref/v25.05" "Pcap++";;

let refiles d =
  refdirs d ~p:Sys.is_regular_file
  |> List.filter (fun f -> not (Sys.file_exists f))
;;

refiles gitref
(* let vibe0 () = *)
(* iterate over ref/${ref} - touch files not exists - mkdir dirs not exists -
   skip dirs: .git *)
;;

let dotfiles () =
  Sys.command "cp ~/em/.clang-format ./" |> ignore;
  Sys.command "cp ~/em/.prettierrc ./" |> ignore

let cpp () =
  touch ("inc/" ^ app ^ ".hpp") ~c:"#pragma once" ();
  touch
    ("src/" ^ app ^ ".cpp")
    ~c:("#include \"" ^ app ^ ".hpp\"

int main() {}
")
    ()

