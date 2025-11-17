ocaml: $(UTOP) $(DUNE) $(OFMT) $(OLSP) .ocamlformat

$(OPAM):
	bash -c "sh <(curl -fsSL https://opam.ocaml.org/install.sh)"
	opam init -a

$(OCAMLC): $(OPAM)
# 	opam switch list-available ; opam switch list
	opam switch create cs3110 ocaml-base-compiler.5.3.0 && touch $@
	opam switch set cs3110 ; eval $(opam env --switch=cs3110)

$(UTOP) $(DUNE) $(OFMT) $(OLSP): $(OCAMLC)
	opam install -y utop dune ocamlformat ocaml-lsp-server

.ocamlformat: $(OFMT)
	echo "version = `ocamlformat --version`" > $@

$(CAMLP5): $(OCAMLC)
	opam install -y camlp5 && touch $@
