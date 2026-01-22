let package () =
  mkd "js" ();
  touch "js/main.js" ();
  touch "package.json"
    ~c:
      [%string
        "{
    \"name\": \"%{String.lowercase_ascii app}\",
    \"version\": \"%{version}\",
    \"description\": \"%{title}\",
    \"main\": \"js/main.js\",
    \"private\": true,
    \"workspaces\": [ \"js/*\" ],
    \"keywords\": [
        \"udp\",
        \"generator\",
        \"multithreaded\",
        \"network\"
    ],
    \"author\": {
        \"name\": \"%{author}\",
        \"email\": \"%{email}\"
    },
    \"license\": \"%{license}\",
    \"repository\": {
        \"type\": \"git\",
        \"url\": \"%{github}\"
    },
    \"bugs\": {
        \"url\": \"%{github}/issues\"
    },
    \"homepage\": \"%{github}/wiki\",
    \"engines\": {
        \"node\": \">=18.0.0\"
    },
    \"scripts\": {
        \"repl\" : \"deno repl\",
        \"start\": \"deno js/main.ts\",
        \"build\": \"tsc\",
        \"build:watch\": \"tsc --watch\",
        \"test\": \"echo \\\"Error: no test specified\\\" && exit 1\"
    },
    \"files\": [
        \"js/\",
        \"res/\",
        \"inc/\",
        \"src/\",
        \"CMakeLists.txt\",
        \"cmake/\"
    ],
}
"]
    ()

let aptjs () =
  append "apt.Debian" ~c:"nodejs npm\n" ();
  append "apt.Ubuntu" ~c:"nodejs npm\n" ();
  append "apt.Raspbian" ~c:"nodejs npm\n" ()

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

let js () =
  package ();
  aptjs ();
  ts ();
  Sys.command "cp ~/em/.prettierrc ./" |> ignore;
  Sys.command "git add *.json apt.*" |> ignore
