CURL   = curl -L -o
CF     = clang-format -style=file -i
GITREF = git clone -o gh --depth 1
#
PY     = python3
PIP    = pip3
PEP    = autopep8 --ignore $(PEPS) -i
#
PY     = $(BIN)/python3
PIP    = $(BIN)/pip3
PEP    = $(BIN)/autopep8 --ignore $(PEPS) -i
#
RUSTUP = $(CAR)/bin/rustup
CARGO  = $(CAR)/bin/cargo
#
OPAM   = /usr/local/bin/opam
OCAMLC = $(ODIR)/ocamlc
UTOP   = $(ODIR)/utop
DUNE   = $(ODIR)/dune
OFMT   = $(ODIR)/ocamlformat
OLSP   = $(ODIR)/ocamllsp
#
NPM    = /usr/bin/npm
TSC    = $(HOME)/.npm/bin/tsc
DENO   = $(HOME)/.npm/bin/deno
#
GO     = /usr/local/go/bin/go
GOPLS  = $(GOPATH)/bin/gopls
YO     = $(HOME)/.npm/bin/yo
#
QUCS   = /usr/bin/qucs-s
SPICE  = /usr/bin/ngspice
