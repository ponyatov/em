let ocaml () =
  touch ".ocamlinit"
    ~c:
      "\
#require \"ppx_string\";;
#use \"lib/meta.ml\";;
#use \"lib/files.ml\";;
#use \"lib/oca.ml\";;
#use \"lib/vscode.ml\";;
#use \"lib/cpp.ml\";;
#use \"lib/cmake.ml\";;
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
