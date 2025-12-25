OCAML_VER ?= 5.4.0

ocaml: $(UTOP) $(DUNE) $(OFMT) $(OLSP) .ocamlformat .ocamlformat

$(OPAM):
	bash -c "sh <(curl -fsSL https://opam.ocaml.org/install.sh)"
$(HOME)/.opam: $(OPAM)
# sudo apt install -uy bubblewrap | --disable-sandboxing
	opam init --bare --disable-sandboxing -a

$(OCAMLC): $(OPAM)
# 	opam switch list-available ; opam switch list
	opam switch create default ocaml-base-compiler.5.4.0 && touch $@
# 	opam switch create cs134b ocaml-base-compiler.5.4.0 && touch $@
# 	opam switch create cs3110 ocaml-base-compiler.5.2.0 && touch $@
	opam switch set default ; eval $(opam env --switch=default)
# 	opam switch set cs3110 ; eval $(opam env --switch=cs134b)

$(UTOP) $(DUNE) $(OFMT) $(OLSP): $(OCAMLC)
	opam install -y utop dune ocamlformat ocaml-lsp-server ppx_string menhir
	$(MAKE) .ocamlformat .ocamlinit

.ocamlformat: $(OFMT)
	echo "version = `ocamlformat --version`" > $@

.ocamlinit:$(UTOP)
	echo "#use "topfind";;" > $@

$(CAMLP5): $(OCAMLC)
	opam install -y camlp5 && touch $@
