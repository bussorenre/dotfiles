#!/bin/bash

branch="develop"
author="Ryo Matsumoto"
since=`date +%F`
until=`date +%F`

# Options have to be more effective
if [ -n "$1" ]; then
  since=$1
fi

if [ -n "$2" ]; then
  until=$2
fi

git log ${branch} --all --oneline --no-merges --author="${author}" --since=${since} --until=${until} --shortstat |\
  grep changed |\
  cut -d" " -f5 -f7 |\

# awk -F " " 'BEGIN {add=0;del=0} {add+=$1;del+=$2} END {print NR " commits " "\033[0;32m+" add "\033[0;39m/\033[0;31m-" del "\033[0;39m"}'
  awk -F " " 'BEGIN {add=0;del=0} {add+=$1;del+=$2} END {print NR " commits " "+" add "/-" del}'


