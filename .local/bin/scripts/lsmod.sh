#!/bin/sh
lsmod | awk '{print $1}' | xargs -i sh -c 'printf {}, && modinfo -d {}; printf n' | rg w+ | column -t -s, | less
