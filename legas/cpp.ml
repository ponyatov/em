let cMakeLists () =
  touch "CMakeLists.txt" ()

let cMakePresets () =
  touch "CMakePresets.json" ()

let cmake () =
  mkd "cmake" ();
  cMakeLists (); cMakePresets()
  
let hpp () =
  mkd "inc" ();
  touch [%string "inc/%{app}.hpp"] ()

let cpp () =
  mkd "src" ();
  touch [%string "src/%{app}.cpp"] ()

let doxygen () =
  Sys.command "doxygen -l" |> ignore;
  Sys.command "mv DoxygenLayout.xml doc/" |> ignore;
  touch ".doxygen"
    ~c:
      [%string "\
PROJECT_NAME           = \"%{app}\"
PROJECT_BRIEF          = \"%{title}\"
PROJECT_LOGO           = doc/logo.png
LAYOUT_FILE            = doc/DoxygenLayout.xml
OUTPUT_DIRECTORY       = doc
HTML_OUTPUT            = html
INPUT                  = README.md doc inc src
INPUT                 += hw cpu arch os
INCLUDE_PATH           = inc
EXCLUDE                = ref/* lib/python* *.pdf *.djvu
WARN_IF_UNDOCUMENTED   = NO
RECURSIVE              = YES
USE_MDFILE_AS_MAINPAGE = README.md
GENERATE_LATEX         = NO
FILE_PATTERNS         += *.lex *.yacc *.ragel *.rl
EXTENSION_MAPPING      = lex=C++ yacc=C++ ragel=C++ rl=C++ ino=C++
HAVE_DOT               = YES
EXTRACT_ALL            = YES
EXTRACT_STATIC         = YES
EXTRACT_PRIVATE        = YES
EXTRACT_PACKAGE        = YES
EXTRACT_LOCAL_CLASSES  = YES
EXTRACT_LOCAL_METHODS  = YES
EXTRACT_ANON_NSPACES   = YES
SORT_GROUP_NAMES       = YES
REPEAT_BRIEF           = NO
CALL_GRAPH             = YES
CALLER_GRAPH           = YES
"]
    ()
  
let cf () =
  Sys.command "cp ~/em/.clang-format ./" |> ignore

let   c_cpp_properties () =
  touch ".vscode/c_cpp_properties.json" ()


let cpp () =
  mkd "src" ();
  hpp () ; cpp ();
  cmake ();
  doxygen ();
  cf ();
  c_cpp_properties ()
