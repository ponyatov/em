let app = Sys.getcwd() |> String.split_on_char '/' |> List.rev |> List.hd
let orig = "ref/v25.05"
let title = "Espruino /vibe"
let author = "Dmitry Ponyatov"
let email = "dponyatov@gmail.com"
let year = 2025
let license = "MIT"

let touch name ?(c = "") () =
  (* if not (Sys.file_exists name) then *)
  let f = open_out name in
  output_string f c;
  close_out f

let mkd name ?(c = "!.gitignore\n") () =
  if not (Sys.file_exists name) then Sys.mkdir name 0o755;
  touch (name ^ "/.gitignore") ~c ()

open Unix

let ocaml () =
  touch ".ocamlinit" ~c:"#use \"topfind\";;
#require \"unix\";;
(* #require \"ppx_string\";; *)
" ()

  let ic = Unix.open_process_in "ocamlformat --version" in
  let version = input_line ic in
  (ignore (Unix.close_process_in ic);

  touch ".ocamlformat" ~c:("version = " ^ version ^ "
profile = default
margin=80
line-endings=lf
break-cases=all
wrap-comments=true
break-string-literals=never
# break-infix-before-func = false
# break-infix = fit-or-vertical
# break-separators = after
# let-and = sparse
") ())

let dirs () =
  [ ".vscode"; "lib"; "inc"; "src"]
  |> List.iter (fun d -> mkd d ())

let bins () =
  [ "bin"; "tmp"; "ref" ] |> List.iter (fun d -> mkd d ~c:"*\n!.gitignore\n" ())

let doc () = mkd "doc" ~c:"html/\n!.gitignore\n" ()

let giti () = touch ".gitignore" ~c:"*~
*.swp
*.log
!.gitignore
" ()

let mk () =
  touch "Makefile" ()

  let vibe0 () = 
    (* iterate over ref/${ref} 
    - touch files not exists
    - mkdir dirs not exists
    - skip dirs: .git *)