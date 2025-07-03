//! generic embedded project generation script in F#

open System
open System.IO

let APP = "Evento"
let VERSION = "0.0.1"
let TITLE = "Embedded Programming Language Prototype"
let ABOUT = ""
let AUTHOR = "Dmitry Ponyatov"
let EMAIL = "dponyatov@gmail.com"
let YEAR = 2025
let LICENSE = "MIT"
let GITHUB = $"https://github.com/ponyatov/{APP}"
let USER = Environment.UserName
let HOME = Environment.GetFolderPath(Environment.SpecialFolder.UserProfile)

let CLONE = $"git clone -o gh git@github.com:ponyatov/{APP}.git ~/{APP}"

Directory.SetCurrentDirectory($"{HOME}/{APP}")
