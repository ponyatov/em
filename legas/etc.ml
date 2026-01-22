let etcservice () =
  let systemd = [%string "/etc/systemd/system/%{app}@$USER.service"] in
  touch [%string "etc/%{app}.service"]
    ~c:
      [%string
        "# sudo ln -fs ~/%{app}/etc/%{app}.service %{systemd}
# ls -la %{systemd}
#
# sudo systemctl daemon-reload
# sudo systemctl stop    %{app}@$USER
# sudo systemctl start   %{app}@$USER
# sudo systemctl status  %{app}@$USER
#
# sudo systemctl enable  %{app}@$USER
# sudo systemctl disable %{app}@$USER
#
# cat /sys/fs/cgroup/%{app}/memory.max
# cat /sys/fs/cgroup/%{app}/memory.swap.max
# sudo lib/pcpp/setup_dpdk.py status

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
"]
    ()

let etcconfig () =
  touch [%string "etc/%{app}.config"]
    ~c:[%string "#!/bin/sh
MAX=111M
SWAP=1M
"] ()

let etcstart () =
  touch [%string "etc/%{app}.start"]
    ~c:
      [%string
        "#!/bin/sh
. $(dirname $0)/%{app}.config
# sudo systemctl daemon-reload
# sudo systemctl enable  %{app}@$USER
# sudo systemctl start   %{app}@$USER
# sudo systemctl status  %{app}@$USER

cgcreate -g memory:%{app}
echo $MAX  | tee /sys/fs/cgroup/%{app}/memory.max
echo $SWAP | tee /sys/fs/cgroup/%{app}/memory.swap.max
echo 1     | tee /sys/fs/cgroup/%{app}/memory.oom.group
# cat /sys/fs/cgroup/%{app}/memory.max
# cat /sys/fs/cgroup/%{app}/memory.swap.max
# cat /sys/fs/cgroup/%{app}/memory.oom.group
"]
    ()

let etcstop () =
  touch [%string "etc/%{app}.stop"]
    ~c:
      [%string
        "#!/bin/sh
. $(dirname $0)/%{app}.config
# sudo systemctl daemon-reload
# sudo systemctl disable %{app}@$USER
# sudo systemctl stop    %{app}@$USER
# sudo systemctl status  %{app}@$USER

cgdelete -g memory:%{app}
# ls -la /sys/fs/cgroup/%{app}
"]
    ()

let etc () =
  mkd "etc" ();
  etcconfig ();
  etcservice ();
  etcstart ();
  etcstop ();
  (* touch ("etc/"^app^".stop") (); *)
