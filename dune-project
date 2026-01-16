(lang dune           3.20)
(name                cs3110)
(generate_opam_files true)
(authors             "Michael R. Clarkson")
(maintainers         "Dmitry Ponyatov <dponyatov@gmail.com>")
(bug_reports         "dponyatov@gmail.com")
(homepage            "https://github.com/ponyatov/cs3110")
(documentation       "https://github.com/ponyatov/cs3110/wiki")
(license             "MIT")
(source              (github ponyatov/cs3110))
(package
 (name               cs3110)
 (synopsis           "OCaml Programming: Correct + Efficient + Beautiful")
 (description        "
- OCaml workout
- Coursebook
")
 (tags   (OCaml "programming language" compiler REPL embedded))
 (depends ocaml utop dune ocamlformat ocaml-lsp-server ppx_string menhir ounit2)
 (allow_empty))
