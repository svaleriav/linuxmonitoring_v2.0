#!/bin/bash

declare -x code=""
declare -x ErrorCode=""

while read -r line
do
        code="$(echo $line | awk '{print $8}')"
        ErrorCode=${code:0:1}
        if [ $ErrorCode == "5" ] || [ $ErrorCode == "4" ];
        then
                echo $line
        fi
done < tmp.txt