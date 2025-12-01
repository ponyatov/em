let touch name ?(c = "") () =
  (* if not (Sys.file_exists name) then *)
  let f = open_out name in
  output_string f c;
  close_out f

let mkd name ?(c = "!.gitignore\n") () =
  if not (Sys.file_exists name) then Sys.mkdir name 0o755;
  touch (Filename.concat name ".gitignore") ~c ()

let cMakeLists () = touch "CMakeLists.txt" ()
let cMakePresets () = touch "CMakePresets.json" ()

let cmake () =
  cMakeLists ();
  cMakePresets ();
  mkd "cmake" ()
