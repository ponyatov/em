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

let README:unit =
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

