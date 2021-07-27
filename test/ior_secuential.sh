#!/bin/bash

/opt/ior/bin/ior -k -w -r -o xpn:///test_8_8k  -t 8k  -b 1m -s 1024 -i 10
/opt/ior/bin/ior -k -w -r -o xpn:///test_8_64k -t 64k -b 1m -s 1024 -i 10
/opt/ior/bin/ior -k -w -r -o xpn:///test_8_1m  -t 1m  -b 1m -s 1024 -i 10
/opt/ior/bin/ior -k -w -r -o xpn:///test_8_64m -t 64m -b 1m -s 1024 -i 10