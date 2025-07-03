let makefile: unit = File.WriteAllText("Makefile")

let var: unit = //
    File.WriteAllText(
        "mk/var.mk",
        "# var
APP     = $(notdir $(CURDIR))
REL     = $(shell git rev-parse --short=4    HEAD)
BRANCH  = $(shell git rev-parse --abbrev-ref HEAD)
NOW     = $(shell date +%y%m%d)
PEPS    = E26,E302,E305,E401,E402,E701,E702
BINFILE = $(APP)_$(HW)_$(BRANCH)_$(REL)_$(NOW)

ifeq ($(OS),Windows_NT)
\tWS  = $(shell uname -o)
\tEXE = .exe
else
\tWS  = $(shell lsb_release -si)
\tEXE =
endif
"
    )

let dir: unit = //
    File.WriteAllText(
        "mk/dir.mk",
        """CWD       = $(CURDIR)
BIN       = $(CWD)/bin
DOC       = $(CWD)/doc
LIB       = $(CWD)/lib
INC       = $(CWD)/inc
SRC       = $(CWD)/src
TMP       = $(CWD)/tmp
REF       = $(CWD)/ref
#
CAR       = $(HOME)/.cargo
ROOT      = $(CWD)/root
BOOT      = $(ROOT)/boot
DISTR    ?= $(HOME)/distr
"""
    )

let tool: unit = //
    File.WriteAllText(
        "mk/tool.mk",
        """CURL   = curl -L -o
CF     = clang-format -style=file -i
GITREF = git clone -o gh --depth 1
PEP    = autopep8 --ignore $(PEPS) -i
PY     = python3
PIP    = pip3
RUSTUP = $(CAR)/bin/rustup
CARGO  = $(CAR)/bin/cargo
"""
    )

let all: unit = //
    File.WriteAllText(
        "mk/all.mk",
        ".PHONY: all run
all: $(BIN)/$(BINFILE) $(S)
run: $(BIN)/$(BINFILE) $(S)
\t$^
"
    )


let install: unit = //
    File.WriteAllText(
        "mk/install.mk",
        ".PHONY : install update ref gz
install: $(WS)_install doc ref gz
\t$(MAKE) update
update : $(WS)_update
ref    : $(RF)
gz     : $(GZ)

Debian_install:
# sudo dpkg --add-architecture i386
Debian_update:
\tsudo apt update
\tsudo apt install -uy `cat apt.$(WS)` $(APT)

Msys_install: doc ref gz
\tpacman -Suy
Msys_update:
\tpacman -S $(shell cat apt.$(WS) | tr '\\n' ' ') $(MSYS)
"
    )



let mk: unit =
    Directory.CreateDirectory("mk") |> ignore
    File.WriteAllText("mk/.gitignore", "!.gitignore\n")

    let makes =
        [ "var"
          "version"
          "dir"
          "tool"
          "src"
          "cfg"
          "all"
          "format"
          "rule"
          "doc"
          "install"
          "merge" ]

    for mk in makes do
        File.WriteAllText($"mk/{mk}.mk", "")

    File.WriteAllText(
        $"Makefile",
        (makes
         |> List.map (fun mk -> $"include mk/{mk}.mk")
         |> List.reduce (fun a b -> $"{a}\n{b}"))
        + "\n"
    )

    var
    dir
    tool
    all
    install
