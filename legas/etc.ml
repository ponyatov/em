let ruser = ""^ruser^""

let etcconfig () =
  touch ("etc/"^app^".config") ~c:("#!/bin/sh

# Network devices using kernel driver
# ===================================
# 0000:02:00.0 'NetXtreme BCM5719 Gigabit Ethernet PCIe 1657' if=eno1 drv=tg3 unused=igb_uio,vfio-pci,uio_pci_generic *Active*
# 0000:02:00.1 'NetXtreme BCM5719 Gigabit Ethernet PCIe 1657' if=eno2 drv=tg3 unused=igb_uio,vfio-pci,uio_pci_generic
# 0000:02:00.2 'NetXtreme BCM5719 Gigabit Ethernet PCIe 1657' if=eno3 drv=tg3 unused=igb_uio,vfio-pci,uio_pci_generic
# 0000:02:00.3 'NetXtreme BCM5719 Gigabit Ethernet PCIe 1657' if=eno4 drv=tg3 unused=igb_uio,vfio-pci,uio_pci_generic
# 0000:08:00.1 'MT27800 Family [ConnectX-5] 1017' if=ens1f1np1 drv=mlx5_core unused=igb_uio,vfio-pci,uio_pci_generic
# 0000:82:00.1 'MT27800 Family [ConnectX-5] 1017' if=ens3f1np1 drv=mlx5_core unused=igb_uio,vfio-pci,uio_pci_generic

# generator/sender:
# 0000:08:00.0 'MT27800 Family [ConnectX-5] 1017'
# if=ens1f0np0 drv=mlx5_core unused=igb_uio,vfio-pci,uio_pci_generic *Active*
ETH=ens1f0np0
PCI=0000:08:00.0
SIP=10.120.1.11/24

# receiver:
# 0000:82:00.0 'MT27800 Family [ConnectX-5] 1017'
# if=ens3f0np0 drv=mlx5_core unused=igb_uio,vfio-pci,uio_pci_generic *Active*
# RECV=ens3f0np0
# RIP=10.120.1.111/24
") ();

let etcservice () =
  touch ("etc/"^app^".service") ~c:("# cd /etc/systemd/system/
# sudo ln -fs ~/"^app^"/etc/"^app^".service "^app^"@"^ruser^".service ; ls -la
# sudo systemctl daemon-reload
# sudo systemctl enable  "^app^"@"^ruser^"
# sudo systemctl start   "^app^"@"^ruser^"
# sudo systemctl status  "^app^"@"^ruser^"
# sudo systemctl disable "^app^"@"^ruser^"
# sudo systemctl stop    "^app^"@"^ruser^"
# sudo lib/pcpp/setup_dpdk.py status

[Unit]
Description = "^app^" @ %I
Wants = network-online.target
After = network.target network-online.target

[Service]
Type             = oneshot
RemainAfterExit  = yes
WorkingDirectory = /home/%i/"^app^"
User             = root
Group            = root
ExecStart        = /bin/sh etc/"^app^".start
ExecStop         = /bin/sh etc/"^app^".stop

[Install]
WantedBy = multi-user.target
") ();

let etcstart () =
  touch ("etc/"^app^".start") ~c:("#!/bin/sh
. $(dirname $0)/"^app^".config

cgcreate -g memory:zmq
echo 200M | tee /sys/fs/cgroup/zmq/memory.max
echo 100M | tee /sys/fs/cgroup/zmq/memory.swap.max
echo 1    | tee /sys/fs/cgroup/zmq/memory.oom.group
# cat /sys/fs/cgroup/zmq/memory.max
# cat /sys/fs/cgroup/zmq/memory.swap.max
# cat /sys/fs/cgroup/zmq/memory.oom.group
") ();

let etc () =
  mkd "etc" ();
  etcconfig ();
  etcservice ();
  etcstart ();
  touch ("etc/"^app^".stop") ();
  Sys.command "git add etc"
