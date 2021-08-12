#!/bin/sh
lscpu | rg "CPU MHz" | awk '{printf "%.f\n", $3}'

