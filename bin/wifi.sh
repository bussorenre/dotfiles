#!/bin/bash


# check if airport is available
airport_path="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"
if [[ ! -x $airport_path ]]; then
    echo "airport is not available"
    exit 1
fi

signals=(▂ ▄ ▆)

# get wi-fi informations through Airport
info=(`(eval $airport_path -I | grep -E "^ *(agrCtlRSSI|agrCtlNoise|lastTxRate|SSID):" | awk '{print $2}')`)
if [ ${info[0]} -eq 0 ]; then
    echo "offline"
    exit 1
fi

rssi=${info[0]}
nois=${info[1]}
rate=${info[2]}
ssid=${info[3]}

pow=rssi-nois

signal=""
for ((j = 0; j < "${#signals[@]}"; j++))
do
    #  -55　Excellent
    #  -70　not good
    #  -85　bad
    if ((  $j == 0 && $pow > 30 )) ||
           (( $j == 1 && $pow > 20 )) ||
           (( $j == 2 && $pow > 10 )); then
        # make signal
        signal="${signal}${signals[$j]} "
    else
        signal="${signal} "
    fi
done

echo "${ssid}[ ${signal}]"

