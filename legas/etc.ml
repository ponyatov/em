
let etcservice () =
  let systemd = [%string "/etc/systemd/system/%{app}@%{user}.service"] in
  touch [%string "etc/%{app}.service"] ~c:[%string "\
# sudo ln -fs ~/%{app}/etc/%{app}.service %{systemd}
# ls -la %{systemd}

[Unit]
Description      = %{app} @ %I
Wants            = network-online.target
After            = network.target network-online.target

[Service]
Type             = oneshot
RemainAfterExit  = yes
WorkingDirectory = /home/%i/%{app}
User             = root
Group            = root
ExecStart        = /bin/sh etc/%{app}.start
ExecStop         = /bin/sh etc/%{app}.stop

[Install]
WantedBy         = multi-user.target
"] ()

let etcconfig () =
  touch [%string "etc/%{app}.config"] ~c:[%string "\
#!/bin/sh
MAX=200M
SWAP=100M
"] ()

let etcstart () =
  touch [%string "etc/%{app}.start"] ~c:[%string "\
#!/bin/sh
. $(dirname $0)/%{app}.config
# sudo systemctl daemon-reload
# sudo systemctl enable  %{app}@%{user}
# sudo systemctl start   %{app}@%{user}
# sudo systemctl status  %{app}@%{user}

cgcreate -g memory:%{app}
echo $MAX  | tee /sys/fs/cgroup/%{app}/memory.max
echo $SWAP | tee /sys/fs/cgroup/%{app}/memory.swap.max
echo 1     | tee /sys/fs/cgroup/%{app}/memory.oom.group
# cat /sys/fs/cgroup/%{app}/memory.max
# cat /sys/fs/cgroup/%{app}/memory.swap.max
# cat /sys/fs/cgroup/%{app}/memory.oom.group
"] ()

let etcstop () =
  touch [%string "etc/%{app}.stop"] ~c:[%string "\
#!/bin/sh
. $(dirname $0)/%{app}.config

cgdelete -g memory:%{app}
# ls -la /sys/fs/cgroup/%{app}
"] ()

let etc () =
  mkd "etc" ();
  etcconfig ();
  etcservice ();
  etcstart ();
  etcstop ();
  (* touch ("etc/"^app^".stop") (); *)
  Sys.command "git add etc"
