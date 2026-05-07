let wasmk () =
  append "mk/rust.mk" ~c:"\trustup target add wasm32-unknown-unknown
" ()

let cargowasm () =
     mkd ".cargo" ();
     append ".cargo/cargo.toml" ~c:"" ()

let wasm () =
  wasmk ();
  cargowasm ()
