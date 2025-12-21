let vm_hpp () = 
  (*  *)
  touch "inc/vm.hpp" ~c:"" ()
let vm_cpp () = 
  (*  *)
  touch "src/vm.cpp" ~c:"#include \"app.hpp\"
" ()

let vm () =
  vm_hpp ();
  vm_cpp ()
