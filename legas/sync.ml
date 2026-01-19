let syncmk () =
  touch "mk/sync.mk"
    ~c:
      ".PHONY: sync
sync: $(HOME)/.unison/$(APP).prf doc
\tunison $(APP)
$(HOME)/.unison/$(APP).prf: $(CWD)/.unison
\tln -fs $< $@
"
    ();
  Sys.command "git add mk" |> ignore

let unison () =
  touch ".unison"
    ~c:
      [%string
        "# .unison
## ln -fs ~/%{app}/.unison ~/.unison/%{app}.prf ; unison %{app}

# profile name (optional)
label = %{app} sync

# directories (local/remote)
root = /home/%{user}/%{app}
root = ssh://%{devuser}@%{devserver}//home/%{devuser}/%{app}

# automation
auto   = true
batch  = true
prefer = newer

# temp/build/local-only files ignoring
ignore = Name {.git}
ignore = Name {*~,*.log,*.sw?}
ignore = Name {bin,tmp,ref,_build,target}
ignore = Name {doc/html,lib/pcpp}
ignore = Name {node_modules,.cache}
ignore = Name {*.pyc,__pycache__}
"]
    ();
  Sys.command [%string "ln -fs ~/%{app}/.unison ~/.unison/%{app}.prf"] |> ignore;
  Sys.command [%string "unison %{app}"] |> ignore;
  Sys.command "git add .unison" |> ignore

let sync () =
  syncmk ();
  unison ()
