#!/bin/bash

# get battery information
info=(`pmset -g batt | grep %`)
percent=`echo ${info[2]} | sed 's/;//g'`
charging="charging;"
full="charged;"

if [ ${charging} = ${info[3]} ]; then
    echo "${percent}[⚡]"
elif [ ${full} = ${info[3]} ]; then
    echo "${percent}[█]"
else
    echo "${percent}[ ]"
fi
