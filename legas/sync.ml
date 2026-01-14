let syncmk () =
  touch "mk/sync.mk"
    ~c:
      ".PHONY: sync
sync: $(HOME)/.unison/$(APP).prf doc
\tunison $(APP)
$(HOME)/.unison/$(APP).prf: $(CWD)/.unison
\tln -fs $< $@
"
    ()

let unison () =
  touch ".unison"
    ~c:
      [%string
        "# .unison
## ln -fs ~/%{app}/.unison ~/.unison/%{app}.prf

# profile name (optional)
label = %{app} sync

# directories (local/remote)
root = /home/%{user}/%{app}
root = ssh://%{ruser}@%{devserver}//home/%{ruser}/%{app}

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
    ()

let sync () =
  syncmk ();
  unison ()
