#!/bin/bash
set -x

# 1) Check arguments
if [ $# -lt 1 ]; then
	echo "Usage: $0 <full path where software will be downloaded>"
	exit
fi

# 2) Get arguments
DESTINATION_PATH=$1

# 3) Download XPN
mkdir -p ${DESTINATION_PATH}
cd       ${DESTINATION_PATH}
git clone https://github.com/manuel1688/xpn.git

# 4) Install XPN (from source code)
mkdir -p /home/lab/bin
cd    ${DESTINATION_PATH}/xpn
./scripts/compile/build-me-xpn.sh  -m /home/lab/bin/mpich/bin/mpicc  -i /home/lab/bin

# 4) Compile examples
cd ${DESTINATION_PATH}/xpn/test/performance/xpn
make -j $(nproc) all

cd ${DESTINATION_PATH}/xpn/test/performance/xpn-fault-tolerant
make -j $(nproc) all

cd ${DESTINATION_PATH}/xpn/test/integrity/bypass_c
make -j $(nproc) all

cd ${DESTINATION_PATH}/xpn/
make install

#syscall_intercept (Intel)
cd /home/lab/src/xpn/src/xpn_syscall_intercept
git clone https://github.com/pmem/syscall_intercept.git
sudo apt install clang -y
sudo apt-get install -y pkg-config libcapstone-dev
cmake syscall_intercept -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER=clang
make
sudo make install
cd /home/lab/src/xpn/src/xpn_syscall_intercept
bash makefile_scripts.sh
cd /home/lab/src/xpn/test/integrity/test_xpn_syscall
make 