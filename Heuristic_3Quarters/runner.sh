#!/bin/bash
# this script is for running matlab scripts in a remote machine
# run this script as > nohup sh runner.sh "matlab file" "output file" > /dev/null $
# for example -> nohup sh runner.sh hello hello.txt > /dev/null &


export LC_ALL="en_US.utf8"
nohup matlab -nodisplay -r "$1" > "$2" </dev/null &
