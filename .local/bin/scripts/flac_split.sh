#!/bin/sh
shntool split -f *.cue -t "%n. %t" -o flac *.flac
