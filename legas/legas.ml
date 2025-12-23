let app = Sys.getcwd () |> String.split_on_char '/' |> List.rev |> List.hd
let title = "OCaml/C compiler"
let about = "
- OCaml workout
- ASCII data parsing
- programming language workbench
"
let author = "Dmitry Ponyatov"
let email = "dponyatov@gmail.com"
let year = 2025
let version = "0.0.1"
let license = "MIT"
let github = "github: https://github.com/ponyatov/" ^ app

(* ln -fs ../em/legas legas       *)
(* cp legas/.ocaml* ./            *)
(* mkdir lib                      *)
(* cp legas/legas.ml lib/legas.ml *)
(* code lib/legas.ml              *)

#use "legas/git.ml"
git();

#use "legas/files.ml"
files();;

#use "legas/vscode.ml"
vscode();;

#use "legas/ocaml.ml"
ocamldots();

#use "legas/doc.ml"
doc();

#use "legas/mk.ml"
mk();

#use "legas/cpp.ml"
cpp();

#use "legas/cli.ml"
cli();

#use "legas/vm.ml"
vm();

#use "legas/cmake.ml"
cmake();

#use "legas/rust.ml"
rust();

#use "legas/js.ml"
js();

#use "legas/sync.ml"
sync();
