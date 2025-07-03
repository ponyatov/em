//! generic embedded project generation script in F#

open System
open System.IO

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

let c_cpp_properties:unit =
    File.WriteAllText(".vscode/c_cpp_properties.json","{\n}\n")

let extensions:unit =
    File.WriteAllText(".vscode/extensions.json","{\n}\n")

let tasks:unit =
    File.WriteAllText(".vscode/tasks.json","{\n}\n")

let launch:unit =
    File.WriteAllText(".vscode/launch.json","{\n}\n")

let settings:unit =
    File.WriteAllText(".vscode/settings.json","""{
    // files
    "C_Cpp.files.exclude": {
        "ref":true,
    },
    "files.exclude": {
        "doc/html": true, "**/node_modules/**": true,
    },
    "files.watcherExclude": {
        "**/bin/**": true, "**/tmp/**": true,
        "ref/**": true, "target/**": true, "obj/**": true,
    },
    "files.associations": {
        "*.mk": "makefile", "*.make": "makefile",
        "*.s": "arm", "*.s.fix": "arm", "*.S": "arm",
        "*.ocd": "properties", "*.gdb": "properties",
        "*.ld": "linkerscript", "*.ld.fix": "linkerscript",
        "*.ioc": "properties", "*.config": "properties",
        "*.kernel": "properties",
        "*.service": "systemd-unit-file",
        "requirements.*": "properties",
        "*.ini": "properties", "*.f": "properties",
    },

    // editor
    "files.eol": "\n",
    "files.insertFinalNewline": true,
    "files.trimFinalNewlines": true,
    "editor.tabSize": 4,
    "editor.insertSpaces": true,
    "editor.detectIndentation": false,
    "editor.rulers": [80],
    "editor.lineNumbers": "on",
    "workbench.tree.indent": 24,
    "editor.fontSize": 14,
    "explorer.autoReveal": false,
    "terminal.integrated.copyOnSelection": true,
    "editor.formatOnSave":  false,
    "git.enabled": false,

    // terminal
    "SerialTerminal.serial port.configurations": ["115200n1"],

    // JavaScript
    "prettier.configPath"         : ".prettierrc",
    "prettier.requireConfig"      :  true,
    "json.format.enable"          :  true,

    // clang-format
    "clang-format.executable"     : "clang-format",
    "clang-format.fallbackStyle"  : "Google",
    "clang-format.style"          : "file",

    // C++
    "[c]"  : { "editor.defaultFormatter" : "xaver.clang-format" },
    "[cpp]": { "editor.defaultFormatter" : "xaver.clang-format" },
    "C_Cpp.default.configurationProvider": "ms-vscode.cmake-tools",
    // "C_Cpp.intelliSenseEngine": "Tag Parser",

    // CMake
    "cmake.sourceDirectory" : "${workspaceFolder}",
    "cmake.buildDirectory"  : "${workspaceFolder}/tmp/${workspaceFolderBasename}",
    "cmake.generator"       : "Unix Makefiles",
    "cmake.parallelJobs"    :  2,
    "cmake.useCMakePresets" : "always",
    "cmake.ignoreCMakeListsMissing" : false,
    "cmake.buildBeforeRun"  :  true,
    "cmake.saveBeforeBuild" :  true,
    "cmake.debugConfig"     : {
        "cwd" :   "${workspaceFolder}",
        "args": [ "lib/${workspaceFolderBasename}.ini" ] },
    "cmake.allowCommentsInPresetsFile" : true,

    // Python
    "python.defaultInterpreterPath":  "python3",
    "autopep8.path"                : ["autopep8"],
    "autopep8.args"                : ["--ignore","E26,E302,E305,E401,E402,E701,E702"],
    "python.analysis.extraPaths"   : ["${workspaceFolder}/src"],
    "[python]": { "editor.defaultFormatter"  : "ms-python.autopep8" },

    // Rust
    "rust-analyzer.checkOnSave"          : false,
    "rust-analyzer.check.allTargets"     : false,
    "rust-analyzer.cargo.target"         : "x86_64-unknown-linux-gnu",
    "rust-analyzer.cargo.features"       : ["pc","i5","x86_64","linux"],
    // "rust-analyzer.cargo.target"         : "aarch64-unknown-linux-gnu",
    // "rust-analyzer.cargo.target"         : "wasm32-unknown-unknown",
    // "rust-analyzer.cargo.target"         : "thumbv7m-none-eabihf",
    // "rust-analyzer.cargo.features"       : ["pillf103","stm32f1","cortex","cortexm3"],
    // "rust-analyzer.cargo.target"         : "thumbv7em-none-eabihf",
    // "rust-analyzer.cargo.features"       : ["f429disco","cortex","stm32f4"],
    // "rust-analyzer.cargo.target"         : "i686-pc-windows-gnu",
    "[rust]": { "editor.defaultFormatter": "rust-lang.rust-analyzer" },

    // F#
    "[fsharp]": {
        "editor.defaultFormatter": "Ionide.Ionide-fsharp",
        "editor.formatOnSave"    :  true
    },

    // MinGW/MSYS2
    "terminal.integrated.defaultProfile.windows": "UCRT64",
    "terminal.integrated.profiles.windows": {
      "UCRT64": {
        "path": "C:\\msys64\\usr\\bin\\bash.exe",
        "args": ["--login","-i"],
        "env": {
          "MSYSTEM": "UCRT64",
          "CHERE_INVOKING": "1",
        }}},
}
""")

let vscode:unit = 
    Directory.CreateDirectory(".vscode") |> ignore
    File.WriteAllText(".vscode/.gitignore","!.gitignore\n")
    c_cpp_properties
    extensions
    tasks
    launch
    settings

let bin:unit = 
    Directory.CreateDirectory("bin") |> ignore
    File.WriteAllText("bin/.gitignore","*\n!.gitignore\n")

let doc:unit = 
    Directory.CreateDirectory("doc") |> ignore
    File.WriteAllText("doc/.gitignore","html/\n!.gitignore\n")

let lib:unit = 
    Directory.CreateDirectory("lib") |> ignore
    File.WriteAllText("lib/.gitignore","!.gitignore\n")
    File.WriteAllText($"lib/{APP}.ini","# line comment\n")

let inc:unit = 
    Directory.CreateDirectory("inc") |> ignore
    File.WriteAllText("inc/.gitignore","!.gitignore\n")

let hpp:unit =
    File.WriteAllText($"inc/{APP}.hpp","")
let cpp:unit =
    File.WriteAllText($"src/{APP}.cpp","")
let lex:unit =
    File.WriteAllText($"src/{APP}.lex","")
let yacc:unit =
    File.WriteAllText($"src/{APP}.yacc","")

let src:unit = 
    Directory.CreateDirectory("src") |> ignore
    File.WriteAllText("src/.gitignore","!.gitignore\n")
    hpp
    cpp
    lex
    yacc

let tmp:unit = 
    Directory.CreateDirectory("tmp") |> ignore
    File.WriteAllText("tmp/.gitignore","*\n!.gitignore\n")

let ref:unit = 
    Directory.CreateDirectory("ref") |> ignore
    File.WriteAllText("ref/.gitignore","*\n!.gitignore\n")


let dirs:unit =
    vscode
    bin
    doc
    lib
    inc
    src
    tmp
    ref

let giti:unit =
    File.WriteAllText(".gitignore","~\n*.swp\n*.log\n*.exe\n*.o\ntarget/\nobj/\n!.gitignore\n")

let cf:unit =
    File.WriteAllText(".clang-format","")

let prettier:unit =
    File.WriteAllText(".prettierc","")

let doxygen:unit =
    File.WriteAllText(".doxygen","")

let editorconfig:unit =
    File.WriteAllText(".editorconfig","")

let apt:unit =
    File.WriteAllText("apt.Debian","")

let makefile:unit = 
    File.WriteAllText("Makefile")

let mk:unit =
    Directory.CreateDirectory("mk") |> ignore
    File.WriteAllText("mk/.gitignore","!.gitignore\n")
    let mk = ""
    for mk in ["var";"version";"dir";"tool";"src";"cfg";"all";"format";"rule";"doc";"install";"merge"] do
        File.WriteAllText($"mk/{mk}.mk","")
    File.WriteAllText($"Makefile",mk)

let cmake:unit =
    Directory.CreateDirectory("cmake") |> ignore
    File.WriteAllText("mk/.gitignore","!.gitignore\n")

let files:unit =
    giti
    cf
    prettier
    editorconfig
    apt
    mk
    cmake

let fs:unit =
    File.WriteAllText($"lib/{APP}.fs","")
    File.WriteAllText($"lib/VSCode.fs","")
    File.WriteAllText($"lib/Make.fs","")
    File.WriteAllText($"lib/CMake.fs","")
    File.WriteAllText($"{APP}.fsproj","")

let project: unit =
    dirs
    files
    fs

COMMIT
