#!/bin/bash


# check if airport is available
airport_path="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"
if [[ ! -x $airport_path ]]; then
    echo "airport is not available"
    exit 1
fi

signals=(▂ ▄ ▆)

# get wi-fi informations through Airport
info=(`(eval $airport_path -I | grep -E "^ *(agrCtlRSSI|state|lastTxRate|SSID):" | awk '{print $2}')`)
if [ ${info[0]} -eq 0 ]; then
    echo "offline"
    exit 1
fi

rssi=${info[0]}
rate=${info[2]}
ssid=${info[3]}

signal=""
for ((j = 0; j < "${#signals[@]}"; j++))
do
    #  -55　Excellent
    #  -70　not good
    #  -85　bad
    if ((  $j == 0 && $rssi > -90 )) ||
           (( $j == 1 && $rssi > -75 )) ||
           (( $j == 2 && $rssi > -60 )); then
        # make signal
        signal="${signal}${signals[$j]} "
    else
        signal="${signal}. "
    fi
done

echo "${ssid} ${rate}Mbps ${signal}"

