module VSCode

let c_cpp_properties: unit =
    File.WriteAllText(
        ".vscode/c_cpp_properties.json",
        """{
    "version": 4,
    "env":{
        "appInclude": [
            "${workspaceFolder}/inc/**",
            "${workspaceFolder}/tmp/**",
            "${workspaceFolder}/src/**"
        ]
    },
    "configurations": [
        {
            "name"                 : "cmake",
            "configurationProvider": "ms-vscode.cmake-tools",
            "mergeConfigurations"  :  true,
            "includePath": [
                "${appInclude}"
            ],
            "defines": [
                "PC", "I5", "X86_64", "LINUX"
            ]
        }
    ]
}
"""
    )

let extensions: unit = File.WriteAllText(".vscode/extensions.json", "{\n}\n")

let tasks: unit = File.WriteAllText(".vscode/tasks.json", "{\n}\n")

let launch: unit = File.WriteAllText(".vscode/launch.json", "{\n}\n")

let settings: unit =
    File.WriteAllText(
        ".vscode/settings.json",
        """{
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
"""
    )

let vscode: unit =
    mkdir ".vscode"
    c_cpp_properties
    extensions
    tasks
    launch
    settings
