Sys.command("ln -fs ../rc rc")
Sys.command("ln -fs ../em/legas legas")
Sys.command("cp legas/.ocaml* ./")
Sys.command("mkdir lib")
Sys.command("cp ~/em/legas/legas.ml lib/legas.ml")
Sys.command("code lib/legas.ml")

let app = Sys.getcwd () |> String.split_on_char '/' |> List.rev |> List.hd
let title = "OCaml/C compiler"
let about = "
- OCaml workout
- ASCII data parsing
- programming language workbench
"
let user = "dponyatov"
let ruser = "dimon"
let devserver = "10.110.1.101"

let author = "Dmitry Ponyatov"
let email = "dponyatov@gmail.com"
let year = 2025
let version = "0.0.1"
let license = "MIT"
let github = "github: https://github.com/ponyatov/" ^ app
let gitflic = "github: https://gitflic.ru/project/"^user^"/" ^ app

#use "legas/git.ml"
git();

#use "legas/files.ml"
files();;

#use "legas/vscode.ml"
vscode();;

#use "legas/ocaml.ml"
ocamldots();
(* dune() *)

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

(* #use "legas/sync.ml" *)
#use "legas/etc.ml"
etc();
