let ocamldots () =
  touch ".ocamlinit"
    ~c:
      {|#use "topfind";;
#require "unix";;
open Unix;;
#require "ppx_string";;
|}
    ();

  let ic = Unix.open_process_in "ocamlformat --version" in
  let version = input_line ic in
  Unix.close_process_in ic |> ignore;

  touch ".ocamlformat"
    ~c:
      ("version=" ^ version
     ^ {|
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
|}
      )
    ();
  Sys.command "git add .ocaml*"

let dune () =
  touch ("lib/" ^ app ^ ".ml") ~c:("(** " ^ title ^ " *)\n") ();
  touch "lib/test.ml" ~c:("(** " ^ app ^ " tests *)\n") ();
  touch "lib/hello.ml" ~c:"(** Hello, OCaml *)\n" ();
  touch "lib/dune"
    ~c:
      [%string
        "\
; (executable
;   (name hello)
;   (public_name hello)
;   (modules hello)
;   (libraries %{app})
;   (package hello))
 
(library
  (name %{app})
  (modules %{app})
  (libraries ppx_string)
  (preprocess (pps ppx_string))
  (package %{app}))

(test
  (name test)
  (modules test)
  (libraries %{app})
  (package %{app}))
"]
    ();
  touch "dune-project"
    ~c:
      [%string
        "\
(lang dune           3.20)
(name                %{app})
(generate_opam_files true)
(authors             \"%{author} <%{email}>\")
(maintainers         \"%{author} <%{email}>\")
(bug_reports         \"%{email}\")
(homepage            \"%{github}\")
(documentation       \"%{github}/wiki\")
(license             \"%{license}\")
(source              (github ponyatov/%{app}))
(package
 (name               %{app})
 (synopsis           \"%{title}\")
 (description        \"\n%{about}\")
 (tags   (OCaml \"programming language\"))
s (depends ocaml utop dune ocamlformat ocaml-lsp-server ppx_string menhir ounit2)
 (allow_empty))
"]
    ();
  Sys.command "dune build";
  Sys.command "git add dune* *.opam lib"

let otools () =
  append "mk/tool.mk" ~c:[%string "\
#
OPAM   = /usr/local/bin/opam
OCAMLC = $(CAML)/bin/ocamlc
DUNE   = $(CAML)/bin/dune
UTOP   = $(CAML)/bin/utop
OFMT   = $(CAML)/bin/ocamlformat
OLSP   = $(CAML)/bin/ocamllsp
OPPX   = $(CAML)/bin/ppx-base
CAMLP  = $(CAML)/bin/camlp5o
"] ()

let ocaml () =
  ocamldots ();
  dune ();
  otools ()
