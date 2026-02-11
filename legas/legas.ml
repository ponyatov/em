Sys.command("git init")|>ignore;
Sys.command("ln -fs ../rc rc")|>ignore;
Sys.command("ln -fs ~/em/legas legas")|>ignore;
Sys.command("cp legas/.ocaml* ./")|>ignore;
Sys.command("mkdir lib")|>ignore;
Sys.command("cp ~/em/legas/meta.ml lib/meta.ml")|>ignore;
Sys.command("code lib/meta.ml")|>ignore;

(* edit meta.ml & restart utop *)

#use "lib/meta.ml";;
#use "legas/files.ml";;
files()
#use "legas/git.ml";;
git();

#use "legas/vscode.ml";;
vscode();

#use "legas/mk.ml";;
mk();

(* #use "legas/sync.ml" *)

#use "legas/ocaml.ml"
ocamldots();
(* dune(); otools(); *)

#use "legas/doc.ml";;
doc();

#use "legas/ref.ml";;
ref();

#use "legas/cpp.ml"
(* cpp(); *)
#use "legas/cmake.ml"
(* cmake(); *)

#use "legas/rust.ml"
rust();

#use "legas/js.ml"
js();

#use "legas/etc.ml"
etc();

#use "legas/cli.ml"
cli();

#use "legas/vm.ml"
vm();
