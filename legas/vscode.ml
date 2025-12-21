let extensions () =
<<<<<<< HEAD
  touch ".vscode/extensions.json" ~c:"{
    \"recommendations\": [
=======
  touch ".vscode/extensions.json"
    ~c:
      "{
    \"recommendations\": [
        \"statiolake.vscode-auto-tab-closer\",
>>>>>>> ebc2351d16f8ac53c3e45a30e4e3ceef0045b36d
        \"stkb.rewrap\",
        \"ms-vscode.makefile-tools\",
        \"IBM.output-colorizer\",
        \"usernamehw.errorlens\",
        // formatters
        \"xaver.clang-format\",
        \"esbenp.prettier-vscode\",
        \"foxundermoon.shell-format\",
        // Linux
        \"ms-vscode-remote.remote-ssh\",
        \"coolbear.systemd-unit-file\",
        // C++
        \"ms-vscode.cpptools\",
        \"jeff-hykin.better-cpp-syntax\",
        \"ms-vscode.cmake-tools\",
        \"krosf.vscode-valgrind\",
        // parser
        \"daohong-emilio.yash\",
        \"rreverser.ragel\",
<<<<<<< HEAD
=======
        // embedded
        \"dan-c-underwood.arm\",
        \"zixuanwang.linkerscript\",
        \"ms-vscode.vscode-serial-monitor\",
        // \"espressif.esp-idf-extension\",
>>>>>>> ebc2351d16f8ac53c3e45a30e4e3ceef0045b36d
        // Python
        \"ms-python.python\",
        \"ms-python.autopep8\",
        \"charliermarsh.ruff\",
<<<<<<< HEAD
=======
        // Rust
        \"rust-lang.rust-analyzer\",
        \"tamasfe.even-better-toml\",
        \"vadimcn.vscode-lldb\",
>>>>>>> ebc2351d16f8ac53c3e45a30e4e3ceef0045b36d
        // OCaml
        \"ocamllabs.ocaml-platform\",
    ]
}
<<<<<<< HEAD
" ()

let vscode () = 
  mkd ".vscode";
  touch ".vscode/extensions.json" ();
  touch ".vscode/launch.json" ();
  touch ".vscode/settings.json" ();
  touch ".vscode/c_cpp_properties.json" ();
  touch ".vscode/tasks.json" ();
  extensions()
=======
"
    ()

let launch () =
  touch ".vscode/launch.json"
    ~c:
      "{
    \"version\": \"0.2.0\",
    \"configurations\": [
        {
            \"name\"            : \"cmake:linux\",
            \"type\"            : \"cppdbg\",
            \"request\"         : \"launch\",
            \"cwd\"             : \"${workspaceFolder}\",
            \"program\"         : \"${command:cmake.launchTargetPath}\",
            \"args\"            : [\"lib/${workspaceFolderBasename}.ini\"],
            \"environment\"     : [],
            \"preLaunchTask\"   : \"CMake: build\",
            \"stopAtEntry\"     : true,
            \"externalConsole\" : false,
            \"MIMode\"          : \"gdb\",
            \"miDebuggerPath\"  : \"gdb\",
            \"setupCommands\"   : [
                {\"text\": \"-enable-pretty-printing\",\"ignoreFailures\": true},
                {\"text\": \"source ${workspaceFolder}/.gdbinit\",\"ignoreFailures\": true}
            ]
        }
    ]
}
"
    ()

let settings () =
  touch ".vscode/settings.json"
    ~c:
      "{
    \"files.exclude\": {
        \"doc/html\": true, \"**/node_modules/**\": true, \"_build\": true,
    },
    \"files.watcherExclude\": {
        \"ref/**\": true,
        \"_build/**\": true, \"target/**\": true,
    },
    \"files.associations\": {
        \"*.ini\": \"properties\", \"*.f\": \"properties\"
    },

    // editor
    \"files.eol\": \"\\n\",
    \"files.insertFinalNewline\": true,
    \"files.trimFinalNewlines\": true,
    \"editor.tabSize\": 4,
    \"editor.insertSpaces\": true,
    \"editor.detectIndentation\": false,
    \"editor.rulers\": [80],
    \"editor.lineNumbers\": \"on\",
    \"workbench.tree.indent\": 24,
    \"editor.fontSize\": 14,
    \"explorer.autoReveal\": false,
    \"terminal.integrated.copyOnSelection\": true,
    \"editor.formatOnSave\": false,
    \"files.autoSave\": \"afterDelay\",
    \"files.autoSaveDelay\": 2222,
    \"auto-tab-closer.numLeftTabs\": 5,
    \"auto-tab-closer.numMaxTabs\": 5,
    // \"git.enabled\": false,

    // terminal
    \"SerialTerminal.serial port.configurations\": [\"115200n1\"],

    // JavaScript
    \"prettier.configPath\"         : \".prettierrc\",
    \"prettier.requireConfig\"      :  true,
    \"json.format.enable\"          :  true,

    // clang-format
    \"clang-format.executable\"     : \"clang-format\",
    \"clang-format.fallbackStyle\"  : \"Google\",
    \"clang-format.style\"          : \"file\",

    // C++
    \"[c]\"  : {
        \"editor.defaultFormatter\" : \"xaver.clang-format\",
        \"editor.formatOnSave\": false },
    \"[cpp]\": {
        \"editor.defaultFormatter\" : \"xaver.clang-format\",
        \"editor.formatOnSave\": false },
    \"C_Cpp.default.configurationProvider\": \"ms-vscode.cmake-tools\",
    \"C_Cpp.files.exclude\": { \"ref\": true },

    // CMake
    \"cmake.sourceDirectory\" : \"${workspaceFolder}\",
    \"cmake.buildDirectory\"  : \"${workspaceFolder}/tmp/${workspaceFolderBasename}\",
    \"cmake.generator\"       : \"Unix Makefiles\",
    \"cmake.parallelJobs\"    :  4,
    \"cmake.useCMakePresets\" : \"always\",
    \"cmake.buildBeforeRun\"  :  true,
    \"cmake.saveBeforeBuild\" :  true,
    \"cmake.debugConfig\"     : {
        \"cwd\" :   \"${workspaceFolder}\",
        \"args\": [ \"lib/${workspaceFolderBasename}.ini\" ] },
    \"cmake.allowCommentsInPresetsFile\" : true,
    \"cmake.ignoreCMakeListsMissing\"    : false,

    // Python
    // \"python.defaultInterpreterPath\":  \"${workspaceFolder}/bin/python3\",
    // \"autopep8.path\"                : [\"${workspaceFolder}/bin/autopep8\"],
    // \"ruff.interpreter\"             : [\"${workspaceFolder}/bin/python3\"],
    \"autopep8.args\"                : [\"--ignore\",\"E26,E302,E305,E401,E402,E701,E702\"],
    \"python.analysis.extraPaths\"   : [\"${workspaceFolder}/src\", \"${workspaceFolder}/lib\"],
    \"[python]\": {
        \"editor.defaultFormatter\"  : \"ms-python.autopep8\",
        \"editor.formatOnSave\"      :  true},
    \"ruff.configuration\"               : \".ruff.toml\",
    \"ruff.lint.preview\"                : true,
    \"ruff.format.preview\"              : true,
    \"python.testing.pytestArgs\"        : [\"lib\"],
    \"python.testing.unittestEnabled\"   : false,
    \"python.testing.pytestEnabled\"     : true,

    // Rust
    \"rust-analyzer.checkOnSave\"          : false,
    \"rust-analyzer.check.allTargets\"     : false,
    \"[rust]\": { \"editor.defaultFormatter\": \"rust-lang.rust-analyzer\" },
    \"rust-analyzer.cargo.target\"         : \"x86_64-unknown-linux-gnu\",
    \"rust-analyzer.cargo.features\"       : [\"pc\",\"i5\",\"x86_64\",\"linux\"],

    // OCaml (cs3110)
    \"[ocaml]\": {
        \"editor.tabSize\": 2, \"editor.rulers\": [80],
        \"editor.formatOnSave\": true },
    \"[ocaml.interface]\": {
        \"editor.tabSize\": 2, \"editor.rulers\": [80],
        \"editor.formatOnSave\": true },

    // MinGW/MSYS2
    \"terminal.integrated.defaultProfile.windows\": \"UCRT64\",
    \"terminal.integrated.profiles.windows\": {
        \"UCRT64\": {
            \"path\": \"C:\\\\msys64\\\\usr\\\\bin\\\\bash.exe\",
            \"args\": [\"--login\",\"-i\"],
            \"env\": {
            \"MSYSTEM\": \"UCRT64\",
            \"CHERE_INVOKING\": \"1\",
    }}}
}
"
    ()

let c_cpp_properties () =
  touch ".vscode/c_cpp_properties.json"
    ~c:
      "{
    \"version\": 4,
    \"env\": {
        \"appInclude\": [
            \"${workspaceFolder}/inc/**\",
            \"${workspaceFolder}/tmp/**\",
            \"${workspaceFolder}/src/**\",
            \"${workspaceFolder}/lib/inc/**\" ,\"${workspaceFolder}/lib/*/inc/**\"
        ]
        \"crossInclude\": [
            \"${workspaceFolder}/hw/inc/**\"  ,\"${workspaceFolder}/hw/*/inc/**\"  ,
            \"${workspaceFolder}/cpu/inc/**\" ,\"${workspaceFolder}/cpu/*/inc/**\" ,
            \"${workspaceFolder}/arch/inc/**\",\"${workspaceFolder}/arch/*/inc/**\",
            \"${workspaceFolder}/os/inc/**\"  ,\"${workspaceFolder}/os/*/inc/**\"
        ]
    },
    \"configurations\": [
        {
            \"name\"                 : \"linux\",
            \"configurationProvider\": \"ms-vscode.cmake-tools\",
            \"mergeConfigurations\"  :  true,
            \"includePath\"          : [\"${appInclude}\", \"${crossInclude}\"],
            \"defines\"              : [\"PC\", \"I5\", \"X86_64\", \"LINUX\"],
            \"compilerPath\"         : \"/usr/bin/x86_64-linux-gnu-g++\",
            \"cStandard\"            : \"c17\",
            \"cppStandard\"          : \"c++23\",
            \"intelliSenseMode\"     : \"gcc-x64\"
        }
    ]
}
"
    ()

let tasks () =
  touch ".vscode/tasks.json"
    ~c:
      "{
    \"version\": \"2.0.0\",
    \"tasks\": [
        {
            \"label\"          : \"project: install\",
            \"type\"           : \"shell\",
            \"command\"        : \"make install\",
            \"presentation\"   : {\"focus\": true},
            \"problemMatcher\" : []
        },
        {
            \"label\"          : \"project: update\",
            \"type\"           : \"shell\",
            \"command\"        : \"make update\",
            \"presentation\"   : {\"focus\": true},
            \"problemMatcher\" : []
        },
        {
            \"label\"          : \"git: checkout .vscode\",
            \"type\"           : \"shell\",
            \"command\"        : \"git checkout .vscode/settings.json\",
            \"problemMatcher\" : [],
            \"presentation\"   : {\"showReuseMessage\": false, \"focus\": false, \"reveal\": \"silent\", \"close\": true},
            \"group\"          : {\"kind\": \"build\", \"isDefault\": true}
        },
        {
            \"label\"          : \"make: watch\",
            \"type\"           : \"shell\",
            \"command\"        : \"make watch\",
            // \"dependsOn\"      : \"CMake: build\",
            \"problemMatcher\" : [],
            \"presentation\"   : {\"showReuseMessage\": true, \"focus\": true, \"reveal\": \"silent\", \"close\": false},
            \"group\"          : {\"kind\": \"build\", \"isDefault\": true}
        },
        {
            \"label\"          : \"make: run\",
            \"type\"           : \"shell\",
            \"command\"        : \"make run\",
            // \"dependsOn\"      : \"CMake: build\",
            \"problemMatcher\" : [],
            \"presentation\"   : {\"showReuseMessage\": true, \"focus\": true, \"reveal\": \"silent\", \"close\": false},
            \"group\"          : {\"kind\": \"build\", \"isDefault\": true}
        },
        {
            \"label\"          : \"doxy: gen\",
            \"type\"           : \"shell\",
            \"group\"          : {\"kind\": \"build\", \"isDefault\": true },
            // \"dependsOn\"      : \"CMake: build\",
            \"command\"        : \"make doxy\",
            \"problemMatcher\" : [],
            \"presentation\"   : {\"showReuseMessage\": false, \"focus\": false, \"reveal\": \"silent\", \"close\": false}
        },
        {
            \"label\"          : \"make: sync\",
            \"type\"           : \"shell\",
            \"command\"        : \"make sync\",
            // \"dependsOn\"      : \"CMake: build\",
            \"problemMatcher\" : [],
            \"presentation\"   : {\"showReuseMessage\": true, \"focus\": true, \"reveal\": \"silent\", \"close\": false},
            \"group\"          : {\"kind\": \"build\", \"isDefault\": true}
        },
        {
            \"label\"          : \"AI: context\",
            \"type\"           : \"shell\",
            \"command\"        : \"make ai\",
            \"problemMatcher\" : [],
            \"presentation\"   : {\"showReuseMessage\": true, \"focus\": true, \"reveal\": \"silent\", \"close\": false},
            \"group\"          : {\"kind\": \"build\", \"isDefault\": true}
        },
    ]
}
"
    ()

let vscode () =
  mkd ".vscode" ();
  extensions ();
  settings ();
  tasks ();
  c_cpp_properties ();
  launch ();
  (* Sys.command "meld .vscode ~/em/.vscode" *)
  Sys.command "git add .vscode"
>>>>>>> ebc2351d16f8ac53c3e45a30e4e3ceef0045b36d
