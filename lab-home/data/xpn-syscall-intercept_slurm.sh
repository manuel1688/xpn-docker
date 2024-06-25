#!/bin/bash
set -x
 
sudo chown lab:lab /shared

# 1) build configuration file /shared/config.xml
# 2) start mpi_servers in background
NL=$(cat /work/machines_mpi | wc -l)
/home/lab/src/xpn/scripts/execute/xpn.sh -w /shared -l /work/machines_mpi -x /tmp/ -n $NL start

# 3) start xpn client
mpiexec -np 1 \
        -hostfile        /work/machines_mpi \
        -genv XPN_DNS    /shared/dns.txt  \
        -genv XPN_CONF   /shared/config.xml \
        -genv LD_PRELOAD /home/lab/src/xpn/src/xpn_syscall_intercept/xpn_syscall_intercept.so:$LD_PRELOAD \
        bash /home/lab/src/xpn/test/integrity/test_xpn_syscall/p_cat.sh

# 4) stop mpi_servers
/home/lab/src/xpn/scripts/execute/xpn.sh -w /shared -d /work/machines_mpi stop


