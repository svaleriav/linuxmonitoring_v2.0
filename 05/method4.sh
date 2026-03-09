#!/bin/bash

declare -x code=""
declare -x ErrorCode=""
declare -x ip=""
touch temp.txt
while read -r line
do
        ip="$(echo $line | awk '{print $1}')"
        code="$(echo $line | awk '{print $8}')"
        ErrorCode=${code:0:1}
        if [ $ErrorCode == "5" ] || [ $ErrorCode == "4" ]; then
                if [ "$(grep $ip temp.txt)" == "" ];
                then
                        echo $ip >> temp.txt
                        echo $line
                fi
        fi
done < tmp.txt