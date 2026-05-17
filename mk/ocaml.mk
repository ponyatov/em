OCAML_VER ?= 5.4.0

.PHONY: ocaml
ocaml: $(OCAMLC) $(UTOP) $(DUNE) $(OFMT) $(OLSP) $(OPPX) .ocamlformat .ocamlinit

$(OPAM):
# PROXY=10.110.1.12:8888 ; https_proxy=$PROXY
	bash -c "sh <(curl -x $PROXY -fsSL https://opam.ocaml.org/install.sh)"
# 	sudo install -m 755 /tmp/opam-2.5.0-x86_64-linux /usr/local/bin/opam

$(HOME)/.opam/config: $(OPAM)
# 	sudo apt install -uy bubblewrap | --disable-sandboxing
	opam init --bare --disable-sandboxing -a && opam --version

$(OCAMLC): $(HOME)/.opam/config
# 	opam switch list-available ; opam switch list
	opam switch create default ocaml-base-compiler.5.4.0 --jobs=2
	eval $(opam env --switch=default) ; ocamlc --version
# 	opam var jobs; opam var --global jobs=18 # $CORES/4*3

$(UTOP) $(DUNE) $(OFMT) $(OLSP): $(OCAMLC) .ocamlformat .ocamlinit
	opam install -y utop dune ocamlformat ocaml-lsp-server

$(OPPX): $(OCAMLC)
	opam install -y ppx_string ppx_deriving
# 	opam install -y camlp5 menhir

.ocamlformat:
	echo "version = `ocamlformat --version`" > $@

.ocamlinit:
	echo "#use "topfind";;"   > .ocamlinit
	echo "#require "unix";;" >> .ocamlinit
