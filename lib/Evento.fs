//! generic embedded project generation script in F#

// project metainfo
let APP   = "Evento"
let TITLE = "Embedded Programming Language Prototype"

let ABOUT = "
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
        File.WriteAllText(giti,"!.gitignore\n")

let NewLines = List.reduce (fun a b -> $"{a}\n{b}")

// env
let USER = Environment.UserName
let HOME = Environment.GetFolderPath(Environment.SpecialFolder.UserProfile)

// project dir
let app  = APP.ToLower()
let CWD = $"{HOME}/{APP}"
mkdir CWD
Directory.SetCurrentDirectory(CWD)

let README:unit = //
    File.WriteAllText ("README.md",$"# ![](doc/logo.png) `{APP}` {VERSION}
## {TITLE}

(c) {AUTHOR} <{EMAIL}> {YEAR} {LICENSE}

github: {GITHUB}
{ABOUT}")

// github repo
let INIT = "git init"
let CHECKOUT = $"git checkout --orphan {USER}"
let GH   = $"git remote add gh git@github.com:ponyatov/{app}.git"
let FLIC = $"git remote add flic git@gitflic.ru:dponyatov/{app}.git"
// let CLONE = $"git clone -o gh git@github.com:ponyatov/{app}.git {HOME}/{APP}"
let GITGUI = $"git gui &"
let CODE = $"code -r {CWD} ; code {HOME}/em/lib/Evento.fs"
let RC = "ln -fs ../rc rc"

let COMMIT = $"git add -A ; git commit -am \".\""
let PUSH = $"git push -v -u gh {USER}"

let bin:unit = //
    for d in ["bin"; "tmp"; "ref"] do
        mkdir d
        File.WriteAllText($"{d}/.gitignore","*\n!.gitignore\n")

let doxy: unit = //    
    File.WriteAllText (".doxygen",$"PROJECT_NAME           = \"{APP}\"
PROJECT_BRIEF          = \"{TITLE}\"
PROJECT_LOGO           = doc/logo.png
")
    // let LOGO = "cp ~/icons/control64.png doc/logo.png"
    // let DOXY = "doxygen -l ; mv DoxygenLayout.xml doc/"
    // let DOTX = "meld .doxygen ~/em/.doxygen"

let doc:unit = //
    mkdir "doc"
    File.WriteAllText($"doc/.gitignore","html/\n!.gitignore\n")
    doxy

let lib:unit = //
    mkdir "lib"
    File.WriteAllText($"lib/{APP}.ini", "# line comment\n")

let src:unit = //
    mkdir "inc"
    touch $"inc/{APP}.hpp"
    mkdir "src"
    touch $"src/{APP}.cpp"
    touch $"src/{APP}.lex"
    touch $"src/{APP}.yacc"

let cross_ name = //
    mkdir $"{name}"
    mkdir $"{name}/inc"
    mkdir $"{name}/src"
    File.WriteAllText ($"{name}/inc/{name}.hpp",$"/// @defgroup {name} {name}\n/// @ingroup cross\n")
    File.WriteAllText ($"{name}/src/{name}.cpp",$"#include \"{name}.hpp\"\n")

let hw:unit = //
    cross_ "hw"

    for hw,cpu in [
        ("qemu386","i486"); ("retro","i686"); ("pc","i5");
        ("pillf103","stm32f103c8t6"); ("f429disco","stm32f429zit6");
        ("esp8266","lx106"); ("esp32","lx106");
        ] do
            mkdir $"hw/{hw}"
            File.WriteAllText ($"hw/{hw}/{hw}.mk",$"CPU = {cpu}")
            touch $"hw/{hw}/{hw}.cmake"
            mkdir $"hw/{hw}/inc"
            mkdir $"hw/{hw}/src"
            touch $"hw/{hw}/inc/{hw}.hpp"
            touch $"hw/{hw}/src/{hw}.cpp"

let cpu:unit = //
    cross_ "cpu"

    for cpu,arch in [
        ("i486","i386"); ("i686","i386"); ("i5","x86_64");
        ("stm32f103c8t6","cortexm3"); ("stm32f429zit6","cortexm4");
        ("lx106","xtensa");
        ] do
            mkdir $"cpu/{cpu}"
            File.WriteAllText ($"cpu/{cpu}/{cpu}.mk",$"ARCH = {arch}")
            touch $"cpu/{cpu}/{cpu}.cmake"
            mkdir $"cpu/{cpu}/inc"
            mkdir $"cpu/{cpu}/src"
            File.WriteAllText ( $"cpu/{cpu}/inc/{cpu}.hpp",$"/// #defgroup {cpu} {cpu}\n/// @ingroup cpu\n")
            File.WriteAllText ( $"cpu/{cpu}/src/{cpu}.cpp",$"#include \"{cpu}.hpp\"\n")

let arch:unit = //
    cross_ "arch"

    for arch in [
        "i386"; "x86_64";
        "cortexm"; "cortexm3"; "cortexm4"; "xtensa";
        ] do
            mkdir $"arch/{arch}"
            touch $"arch/{arch}/{arch}.mk"
            touch $"arch/{arch}/{arch}.cmake"
            mkdir $"arch/{arch}/inc"
            mkdir $"arch/{arch}/src"
            File.WriteAllText ( $"arch/{arch}/inc/{arch}.hpp",$"/// #defgroup {arch} {arch}\n/// @ingroup arch\n")
            File.WriteAllText ( $"arch/{arch}/src/{arch}.cpp",$"#include \"{arch}.hpp\"\n")

let os:unit = //
    cross_ "os"
    for os in ["none";"freertos";"linux";"win32"] do
        mkdir $"os/{os}" ; touch $"os/{os}/{os}.mk" ; touch $"os/{os}/{os}.cmake"
        mkdir $"os/{os}/inc" ; mkdir $"os/{os}/src"
        File.WriteAllText ( $"os/{os}/inc/{os}.hpp",$"/// #defgroup {os} {os}\n/// @ingroup os\n")
        File.WriteAllText ( $"os/{os}/src/{os}.cpp",$"#include \"{os}.hpp\"\n")

let cross:unit = //
    hw
    cpu
    arch
    os

let vscode:unit = //
    mkdir ".vscode"
    let jsons = [
        "c_cpp_properties";
        "extensions";
        "launch";
        "settings";
        "tasks" ]
    for j in jsons do
        File.WriteAllText($".vscode/{j}.json","{\n}\n")
    // let MELD = "meld .vscode ~/em/.vscode"

let dirs:unit = //
    bin
    doc
    lib
    src
    cross
    vscode

let mk: unit = //
    mkdir "mk"
    let makes = ["var";"version";"dir";"tool";"src";"all";"format";"rule";"doc";"rust";"python";"install";"ai"]
    for m in makes do
        touch $"mk/{m}.mk"
    File.WriteAllText("Makefile",
        makes |> List.map (fun m -> $"include mk/{m}.mk") |> NewLines)

let cmake: unit = //
    touch "CMakeLists.txt"
    touch "CMakePresets.json"
    mkdir "cmake"
    let cmakes = ["any_toolchain"; "x86_64-linux-gnu"; "arm-none-eabi";
        "xtensa-lx106-elf"; "aarch64-linux-gnu"; "i686-w64-mingw32";
        "syntax"; "FindLEMON"; "FindRAGEL"; "FindReadline";
        "version"; "src"; "install"; "cross"; "clean"]
    for cm in cmakes do
        touch $"cmake/{cm}.cmake"

let giti:unit = //
    File.WriteAllText(".gitignore","""*~
*.swp
*.log
*.o
*.exe
node_modules/
/target/
/obj/
!.gitignore
""")

let apt:unit = //
    File.WriteAllText ("apt.Debian","""git make curl
code meld doxygen clang-format
g++ cmake gdb gdb-multiarch
flex bison libreadline-dev ragel lemon
python3 python3-venv python3-autopep8 python3-ply
dotnet-runtime-9.0 dotnet-sdk-9.0
qemu-system-arm
    gcc-arm-none-eabi openocd newlib-source dfu-util stlink-tools
qemu-system-x86
    g++-mingw-w64-i686
""")


let clang_format:unit = //
    File.WriteAllText (".clang-format","""BasedOnStyle: Google
IndentWidth:  4
TabWidth:     4
UseTab:       Never
ColumnLimit:  80
UseCRLF:      false

SortIncludes: false

AllowShortBlocksOnASingleLine: Always
AllowShortFunctionsOnASingleLine: All
""")

let prettierrc:unit = //
    File.WriteAllText (".prettierrc","""{
    "tabWidth"    : 4,
    "useTabs"     : false,
    "endOfLine"   : "lf",
    "singleQuote" : true,
    "semi"        : true,
    "printWidth"  : 80
}
""")

let editorconfig:unit = //
    File.WriteAllText (".editorconfig","""# fantomas config
indent_size = 4
max_line_length = 80
end_of_line = lf
insert_final_newline = true
""")

let gitattributes:unit = //
    File.WriteAllText (".gitattributes","""* text=auto eol=lf

# All source code in UNIX format
*.c   text diff=cpp
*.cpp text diff=cpp
*.h   text diff=cpp
*.hpp text diff=cpp
*.s   text diff=cpp
*.ld  text diff=cpp

# Binary files
*.bin  binary
*.elf  binary
*.dfu  binary
*.png  binary
*.pdf  binary
*.doc  binary
*.docx binary

# Linux
*.sh      text eol=lf
*.rc      text eol=lf
*.service text eol=lf

# Windows/MSYS
*.bat text eol=crlf
*.ps* text eol=crlf
""")

let format: unit = //
    clang_format
    prettierrc
    editorconfig
    gitattributes

let files :unit = //
    dirs
    mk
    cmake
    giti
    apt
    format

COMMIT
