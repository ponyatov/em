let syncmk () =
  mkd "mk" ();
  touch "mk/sync.mk"
    ~c:
      ".PHONY: sync
sync: doc $(HOME)/.unison/$(APP).prf
\tunison $(APP)
"
    ()

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
  Sys.command [%string "unison %{app}"] |> ignore

let sync () =
  syncmk ();
  unison ()
