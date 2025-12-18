let app = Sys.getcwd () |> String.split_on_char '/' |> List.rev |> List.hd
let title = "precision timer"
let about = "\nprecision timers on server-side Linux\n"
let author = "Dmitry Ponyatov"
let email = "dponyatov@gmail.com"
let year = 2025
let version = "0.0.1"
let license = "MIT"
let github = "github: https://github.com/ponyatov/" ^ app

let legas () =
  mkd "lib" ();
  Sys.command "git checkout --orphan `whoami`";
  Sys.command "ln -fs ../em/legas legas";
  Sys.command "cp ~/em/legas/legas.ml lib/legas.ml";
  Sys.command "git add legas lib";
  Sys.command "code lib/legas.ml"

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
