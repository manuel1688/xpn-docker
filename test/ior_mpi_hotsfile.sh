#!/bin/bash

#1 process

/opt/mpich/bin/mpirun -hostfile /work/machines_mpi -n 8 /opt/ior/bin/ior -k -w -r -o xpn:///test_8_8k  -t 8k  -b 1m -s 128 -i 10 -F
/opt/mpich/bin/mpirun -hostfile /work/machines_mpi -n 8 /opt/ior/bin/ior -k -w -r -o xpn:///test_8_64k -t 64k -b 1m -s 128 -i 10 -F 
/opt/mpich/bin/mpirun -hostfile /work/machines_mpi -n 8 /opt/ior/bin/ior -k -w -r -o xpn:///test_8_1m  -t 1m  -b 1m -s 128 -i 10 -F 
#/opt/mpich/bin/mpirun -hostfile /work/machines_mpi -n 8 /opt/ior/bin/ior -k -w -r -o xpn:///test_8_64m -t 64m -b 1m -s 128 -i 10 -F 

#2 process

/opt/mpich/bin/mpirun -hostfile /work/machines_mpi -n 16 /opt/ior/bin/ior -k -w -r -o xpn:///test_16_8k  -t 8k  -b 1m -s 64 -i 10 -F 
/opt/mpich/bin/mpirun -hostfile /work/machines_mpi -n 16 /opt/ior/bin/ior -k -w -r -o xpn:///test_16_64k -t 64k -b 1m -s 64 -i 10 -F 
/opt/mpich/bin/mpirun -hostfile /work/machines_mpi -n 16 /opt/ior/bin/ior -k -w -r -o xpn:///test_16_1m  -t 1m  -b 1m -s 64 -i 10 -F 
#/opt/mpich/bin/mpirun -hostfile /work/machines_mpi -n 16 /opt/ior/bin/ior -k -w -r -o xpn:///test_16_64m -t 64m -b 1m -s 64 -i 10 -F 

#3 process

/opt/mpich/bin/mpirun -hostfile /work/machines_mpi -n 32 /opt/ior/bin/ior -k -w -r -o xpn:///test_32_8k  -t 8k  -b 1m -s 32 -i 10 -F 
/opt/mpich/bin/mpirun -hostfile /work/machines_mpi -n 32 /opt/ior/bin/ior -k -w -r -o xpn:///test_32_64k -t 64k -b 1m -s 32 -i 10 -F 
/opt/mpich/bin/mpirun -hostfile /work/machines_mpi -n 32 /opt/ior/bin/ior -k -w -r -o xpn:///test_32_1m  -t 1m  -b 1m -s 32 -i 10 -F 
#/opt/mpich/bin/mpirun -hostfile /work/machines_mpi -n 32 /opt/ior/bin/ior -k -w -r -o xpn:///test_32_64m -t 64m -b 1m -s 32 -i 10 -F 