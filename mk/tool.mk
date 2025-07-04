CURL   = curl -L -o
CF     = clang-format -style=file -i
GITREF = git clone -o gh --depth 1
PEP    = autopep8 --ignore $(PEPS) -i
PY     = python3
PIP    = pip3
RUSTUP = $(CAR)/bin/rustup
CARGO  = $(CAR)/bin/cargo
#
GO     = /usr/local/go/bin/go
GOPLS  = $(GOPATH)/bin/gopls
NPM    = /usr/bin/npm
TSC    = $(HOME)/.npm/bin/tsc
YO     = $(HOME)/.npm/bin/yo
