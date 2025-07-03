//! generic embedded project generation script in F#

// project metainfo
let APP = "Evento"
let TITLE = "Embedded Programming Language Prototype"

let ABOUT =
    "
- smart vehicles, industrial automation & IIoT
- targets microcontrollers & embedded Linux
- heterogenous distributed systems
- wireless sensor networks
"

// mostly constant metainfo
let VERSION = "0.0.1"
let AUTHOR = "Dmitry Ponyatov"
let EMAIL = "dponyatov@gmail.com"
let YEAR = 2025
let LICENSE = "MIT"
let GITHUB = $"https://github.com/ponyatov/{APP}"

// file generation
open System
open System.IO

let touch (path: string) : unit =
    if not (File.Exists(path)) then
        File.WriteAllText(path, "")

let mkdir (path: string) : unit =
    if not (Directory.Exists(path)) then
        Directory.CreateDirectory(path) |> ignore

    let giti = Path.Combine(path, ".gitignore")

    if not (File.Exists(giti)) then
        File.WriteAllText(giti, "!.gitignore\n")

// env
let USER = Environment.UserName
let HOME = Environment.GetFolderPath(Environment.SpecialFolder.UserProfile)

// github repo
let CLONE = $"git clone -o gh git@github.com:ponyatov/{APP}.git {HOME}/{APP}"

Directory.SetCurrentDirectory($"{HOME}/{APP}")

let CWD = Environment.CurrentDirectory

let GITFLIC = $"git remote add flic git@gitflic.ru:dponyatov/evento.git"

let CHECKOUT = $"git checkout --orphan {USER}"
let RC = "ln -fs ../rc rc"

let README: unit =
    File.WriteAllText(
        "README.md",
        $"\
# ![logo](doc/logo.png) `{APP}` {VERSION}
## {TITLE}

(c) {AUTHOR} <{EMAIL}> {YEAR} {LICENSE}

github: {GITHUB}/{APP}
{ABOUT}"
    )

let COMMIT = "git add -A ; git commit -am \".\""
let PUSH = $"git push -uv gh {USER}"

let GITGUI = $"git gui &"
let CODE = $"excode {HOME}/{APP}"

let bin: unit =
    mkdir "bin"
    File.WriteAllText("bin/.gitignore", "*\n!.gitignore\n")

let doc: unit =
    mkdir "doc"
    File.WriteAllText("doc/.gitignore", "html/\n!.gitignore\n")

let lib: unit =
    mkdir "lib"
    File.WriteAllText($"lib/{APP}.ini", "# line comment\n")

let inc: unit = mkdir "inc"

let src: unit =
    Directory.CreateDirectory("src") |> ignore
    File.WriteAllText("src/.gitignore", "!.gitignore\n")
    hpp
    cpp
    lex
    yacc

let tmp: unit =
    Directory.CreateDirectory("tmp") |> ignore
    File.WriteAllText("tmp/.gitignore", "*\n!.gitignore\n")

let ref: unit =
    Directory.CreateDirectory("ref") |> ignore
    File.WriteAllText("ref/.gitignore", "*\n!.gitignore\n")


let dirs: unit =
    vscode
    bin
    doc
    lib
    inc
    src
    tmp
    ref

let giti: unit =
    File.WriteAllText(".gitignore", "~\n*.swp\n*.log\n*.exe\n*.o\ntarget/\nobj/\n!.gitignore\n")

let apt: unit = //
    File.WriteAllText(
        "apt.Debian",
        """git make curl
code meld doxygen clang-format
g++ cmake gdb gdb-multiarch
flex bison libreadline-dev ragel lemon
python3 python3-venv python3-autopep8 python3-ply
dotnet-runtime-9.0 dotnet-sdk-9.0
qemu-system-arm
    gcc-arm-none-eabi openocd newlib-source dfu-util stlink-tools
    g++-aarch64-linux-gnu g++-arm-linux-gnueabihf
qemu-system-x86
    g++-mingw-w64-i686
"""
    )

let doxygen: unit = File.WriteAllText(".doxygen", "")

let files: unit =
    giti
    format
    doxygen
    apt
    mk
    cmake

let fsharp: unit =
    touch $"lib/{APP}.fs"
    touch $"lib/VSCode.fs"
    touch $"lib/Format.fs"
    touch $"lib/Make.fs"
    touch $"lib/CMake.fs"
    touch $"{APP}.fsproj"

let project: unit =
    dirs
    files
    fsharp
    cross

COMMIT
