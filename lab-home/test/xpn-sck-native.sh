#!/bin/bash
set -x


sudo chown lab:lab /shared

# 1) build configuration file /shared/config.txt
# 2) start mpi_servers in background
NL=$(cat /work/machines_mpi | wc -l)
/home/lab/src/xpn/scripts/execute/xpn.sh -e sck -w /shared -l /work/machines_mpi -x /tmp/ -n $NL start
sleep 2

# 3) start xpn client
mpiexec -np 1 \
        -hostfile        /work/machines_mpi \
        -genv XPN_CONF   /shared/config.txt \
        /home/lab/src/xpn/test/performance/xpn/open-write-close /xpn/test 10

# 4) stop mpi_servers
/home/lab/src/xpn/scripts/execute/xpn.sh -e sck -w /shared -d /work/machines_mpi stop

