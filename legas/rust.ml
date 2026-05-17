let rustmk () =
  touch "mk/all.mk"
    ~c:
      ".PHONY: all run watch
all:
\tcargo build
run:
\tcargo run -- lib/$(APP).ini
watch:
\tcargo watch -x 'run -- lib/$(APP).ini'
"
    ();
  touch "mk/rust.mk"
    ~c:
      "\
$(RUSTUP) $(CARGO):
# PROXY = -x 10.110.1.12:8888
\tcurl $(PROXY) --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
\t. $HOME/.cargo/env
\trustup self update ; rustup update
\trustup component add rust-analyzer rustfmt
\tcargo install cargo-watch
\trustup target add x86_64-unknown-linux-gnu
"
    ();    
    append "Makefile" ~c:"include mk/rust.mk\n" ();

let toml () =
  touch [%string "src/%{app}.rs"] ();
  touch "Cargo.toml" ~c:[%string "[package]
name        = \"%{app}\"
version     = \"%{version}\"
edition     = \"2024\"
description = \"%{title}\"
authors     = [\"%{author} %{email}\"]
license     = \"%{license}\"
repository  = \"%{github}\"

[[bin]]
name = \"%{app}\"
path = \"src/%{app}.rs\"
"]
      ();

let cargo_config () =
  mkd ".cargo" ();
  touch ".cargo/config.toml" ~c:"\
[build]
target    = \"x86_64-unknown-linux-gnu\"
jobs      = 4

[target.x86_64-unknown-linux-gnu]
rustflags = [\"--cfg\", \"feature=\\\"pc,i5,linux\\\"\"]
linker    = \"x86_64-linux-gnu-gcc\"

[source.crates-io]
replace-with = \"ustc\"

[source.ustc]
registry = \"sparse+https://mirrors.ustc.edu.cn/crates.io-index/\"
[source.tuna]
registry = \"sparse+https://mirrors.tuna.tsinghua.edu.cn/crates.io-index/\"
" ();

let bare_i386 () =
  touch ".cargo/i386-pc-none.json" ~c:"" ();
  touch [%string "src/%{app}.rs"] ~c:"" ();
  touch "mk/all.mk" ~c:"\
.PHONY: all run watch
all:
\tcargo +nightly build -Z build-std
run:
\tcargo +nightly run -Z build-std
watch:
\tcargo watch -x '+nightly build -Z build-std'
" ();
  append "mk/rust.mk" ~c:"\
\trustup component add rust-src --toolchain nightly-x86_64-unknown-linux-gnu
" ();
  touch "rust-toolchain.toml" ~c:"[toolchain]
channel = \"nightly\"
" ();
  append "apt.Debian" ~c:"qemu-system-i386\n" ();
  append "apt.Ubuntu" ~c:"qemu-system-i386\n" ();

let rust () =
  rustmk ();
  cargo_config ();
  toml ();
