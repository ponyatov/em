let orig = "https://github.com/seladb/PcapPlusPlus.git"
let tag = "v25.05"
let ref () = ()

(********************)

let refdirs ?(p = Sys.is_directory) d =
  Sys.readdir d |> Array.to_list
  |> List.filter (fun f -> p (Filename.concat d f))
  |> List.filter (fun f ->
      not (List.mem f [ "."; ".."; ".git"; ".github"; ".vscode" ]))
;;

refdirs gitref |> List.iter (fun d -> mkd d ());;

let rfd ?(p = Sys.is_directory) r d =
  Sys.readdir (Filename.concat r d)
  |> Array.to_list
  |> List.filter (fun f -> p (r ^ '/' ^ d ^ '/' f))
  |> List.map (fun f -> Filename.concat d f)
;;

rfd "ref/v25.05" "Pcap++";;

let refiles d =
  refdirs d ~p:Sys.is_regular_file
  |> List.filter (fun f -> not (Sys.file_exists f))
;;

refiles gitref
(* let vibe0 () = *)
(* iterate over ref/${ref} - touch files not exists - mkdir dirs not exists -
   skip dirs: .git *)
