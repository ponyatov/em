let app = Sys.getcwd () |> String.split_on_char '/' |> List.rev |> List.hd
let title = "Rust/DPDK"
let about = "high-speed traffic generator"
let author = "Dmitry Ponyatov"
let email = "dponyatov@gmail.com"
let year = 2025
let version = "0.0.1"
let license = "MIT"
let github = "github: https://github.com/ponyatov/" ^ app

let legas () =
  mkd "lib";
  Sys.command "cp legas/legas.ml lib/legas.ml";
  Sys.command "code lib/legas.ml"
legas ();;

#use "legas/files.ml"
files();;
#use "legas/appfiles.ml"
appfiles();;

#use "legas/vscode.ml"
vscode()

#use "legas/git.ml";;
git();;

#use "legas/ref.ml";;
ref();

#use "legas/dev01.ml"
dev01();

#use "legas/ocaml.ml"
ocamldots();
(* ocaml(); *)

#use "legas/doc.ml"
doc();

#use "legas/mk.ml"
mk();

#use "legas/cpp.ml"
hpp();cpp();init();

#use "legas/cmake.ml"

#use "legas/rust.ml"
rust();
