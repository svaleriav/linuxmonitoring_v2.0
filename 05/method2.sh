#!/bin/bash

declare -x boba=""
touch temp.txt
while read -r line
do
        boba="$(echo $line | awk '{print $1}')"
        if [ "$(grep $boba temp.txt)" == ""  ];
        then
                echo $boba >> temp.txt
                echo $line

        fi
done < tmp.txt