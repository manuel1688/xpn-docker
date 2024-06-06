#!/bin/bash
set -x

# 1) Check arguments
if [ $# -lt 1 ]; then
	echo "Usage: $0 <full path where software will be downloaded>"
	exit
fi

# 2) Clean-up
DESTINATION_PATH=$1

# 3) Download MPICH
mkdir -p ${DESTINATION_PATH}
cd       ${DESTINATION_PATH}

export MPICC_PATH=/home/lab/bin/mpich/bin/
export MPICC=$MPICC_PATH/mpicc
export CC=$MPICC_PATH/mpicc
export PATH=$MPICC_PATH:$PATH

./bootstrap
./configure --prefix="/home/lab/bin/ior"

make clean
make -j 8
make install

mkdir -p "/home/lab/bin/ior/lib64"
ln    -s "/home/lab/bin/ior/lib64"   "/home/lab/bin/ior/lib"
