#!/bin/bash
set -x
git clone https://github.com/pmem/syscall_intercept.git
sudo apt install clang 
sudo apt-get install pkg-config libcapstone-dev
cmake syscall_intercept -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER=clang
make
sudo make install