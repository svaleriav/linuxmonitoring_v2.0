#!/bin/bash

declare -x boba=""
declare -x buba=""

while read -r line
do
        boba="$(echo $line | awk '{print $8}')"
        buba=${boba:0:1}
        if [ $buba == "5" ] || [ $buba == "4" ];
        then
                echo $line
        fi
done < tmp.txt