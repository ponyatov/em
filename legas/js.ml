let jsdirs () =
  mkd "src" ();
  mkd "static" ();
  mkd "static/cdn" ();

let html () =
  touch "static/index.html" ~c:[%string "<!DOCTYPE html>
<html lang=\"en\">

<head>
    <meta charset=\"UTF-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
    <title>%{app}</title>
    <link rel=\"stylesheet\" href=\"%{app}.css\">
</head>

<body>
</body>

<script src=\"%{app}.js\"></script>

</html>
"] ();
  touch [%string "static/%{app}.css"] ~c:[%string "* {
    background: #222;
    color: lightgreen;
}
"] ();

let ts () = 
  touch [%string "src/%{app}.ts"] ~c:"" ();
  touch [%string "static/%{app}.js"] ~c:"console.log('Hello');\n" ();
  append "static/.gitignore" ~c:"*.?s\n*.map\n" ()

let package () =
  touch "package.json" ~c:      [%string
        "{
    \"name\": \"%{String.lowercase_ascii app}\",
    \"version\": \"%{version}\",
    \"description\": \"%{title}\",
    \"author\": {
        \"name\": \"%{author}\", \"email\": \"%{email}\"
    },
    \"license\": \"%{license}\",
    \"keywords\": [\"CAD\", \"schematic\", \"EDA\", \"drawing\"],
    \"repository\": {
        \"type\": \"git\",
        \"url\": \"%{github}\"
    },
    \"main\": \"static/%{app}.js\",
    \"scripts\": {
        \"build\": \"tsc\",
        \"watch\": \"tsc --watch\",
        \"clean\": \"rm -rf static/*.?s static/*.?s.map\",
        \"start\": \"npx live-server static --port=12345\"
    }
}
"] ();
  touch "tsconfig.json" ~c:"{
  \"compilerOptions\": {
    \"target\": \"ES2020\",
    \"module\": \"ES2020\",
    \"lib\": [\"ES2020\", \"DOM\"],
    \"rootDir\": \"./src\",
    \"outDir\": \"./static\",
    \"strict\": true,
    \"esModuleInterop\": true,
    \"skipLibCheck\": true,
    \"forceConsistentCasingInFileNames\": true,
    \"declaration\": true,
    \"declarationMap\": true,
    \"sourceMap\": true,
    \"moduleResolution\": \"node\",
    \"resolveJsonModule\": true,
    \"isolatedModules\": true,
    \"noUnusedLocals\": true,
    \"noUnusedParameters\": true,
    \"noImplicitReturns\": true,
    \"noFallthroughCasesInSwitch\": true
  },
  \"include\": [\"src/**/*.ts\"],
  \"exclude\": [\"node_modules\", \"static\"]
}
" ();

let aptjs () =
  let c = "nodejs npm\n" in
  append "apt.Debian" ~c ();
  append "apt.Ubuntu" ~c ();
  append "apt.Raspbian" ~c ()

let js () =
  jsdirs ();
  html ();
  ts ();
  package ();
  aptjs () ;
  Sys.command "cp ~/em/.prettierrc ./" |> ignore;
  Sys.command "git add *.json apt.*" |> ignore
  Sys.command "cp doc/logo.png static/logo.png" |> ignore

let ts () =
  touch "js/main.ts" ();
  touch "js/config.ts" ();
  touch "tsconfig.json"
    ~c:
      [%string
        "{
    \"compilerOptions\": {
        \"target\": \"ES6\",
        \"module\": \"commonjs\",
        \"strict\": true,
        \"esModuleInterop\": true,
        \"rootDir\": \"./js\",
        \"outDir\": \"./tmp/ts\"
    },
    \"exclude\": [\"node_modules\", \"dist\", \"js/receiver\", \"js/toplevel\"],
    \"include\": [\"js/*.ts\"]
}
"]
    ()
