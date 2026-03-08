#!/bin/bash

declare -x boba=""
declare -x buba=""
declare -x biba=""
touch temp.txt
while read -r line
do
        biba="$(echo $line | awk '{print $1}')"
        boba="$(echo $line | awk '{print $8}')"
        buba=${boba:0:1}
        if [ $buba == "5" ] || [ $buba == "4" ]; then
                if [ "$(grep $biba temp.txt)" == "" ];
                then
                        echo $biba >> temp.txt
                        echo $line
                fi
        fi
done < tmp.txt