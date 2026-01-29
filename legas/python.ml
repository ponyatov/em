let ruff () =
  touch ".ruff.toml"
    ~c:
      "line-length    = 80
indent-width   = 4
target-version = \"py310\"

ignore = [\"E26\",\"E302\",\"E305\",\"E401\",\"E402\",\"E701\",\"E702\"]

select = [\"E\", \"F\"]

exclude = [
    \".git\",
    \"ref\",
    \"__pycache__\",
    \"*.pyi\",       # Stub files
    \"migrations\",  # Django migrations
]

[format]
quote-style  = \"double\"
indent-style = \"space\"
"
    ()

let pyvar () =
  append "mk/var.mk" ~c:"PEPS    = E26,E302,E305,E401,E402,E701,E702
" ()

let pytool () =
  append "mk/tool.mk"
    ~c:
      "#
PY     = $(CWD)/bin/python3
PIP    = $(CWD)/bin/pip3
PEP    = $(CWD)/bin/autopep8 --ignore $(PEPS) -i
"
    ()

let pymk () = touch "mk/python.mk" ~c:"$(PY) $(PIP):
\tpython3 -m venv .
" ()

let pygit () =
  append "lib/.gitignore" ~c:"python*/\n" ();
  append ".gitignore" ~c:"*.pyc\nlib64\n" ()

let python () =
  pyvar ();
  pytool ();
  pymk ();
  pygit ()
