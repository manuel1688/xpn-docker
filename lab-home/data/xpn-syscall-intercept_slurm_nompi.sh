#!/bin/bash
set -x
 
sudo chown lab:lab /shared

# 1) build configuration file /shared/config.xml
# 2) start mpi_servers in background
NL=$(cat /work/machines_mpi | wc -l)
/home/lab/src/xpn/scripts/execute/xpn.sh -w /shared -l /work/machines_mpi -x /tmp/ -n $NL start

# 3) start xpn client
export WORK_DIR=/shared
export XPN_CONF=$WORK_DIR/xpn.conf

LD_PRELOAD=/home/lab/bin/xpn/lib64/xpn_bypass.so bash /home/lab/src/xpn/test/integrity/test_xpn_syscall/p_cat.sh

# 4) stop mpi_servers
/home/lab/src/xpn/scripts/execute/xpn.sh -w /shared -d /work/machines_mpi stop


