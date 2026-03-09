#!/bin/bash

declare -x ip=""
touch temp.txt
while read -r line
do
        ip="$(echo $line | awk '{print $1}')"
        if [ "$(grep $ip temp.txt)" == ""  ];
        then
                echo $ip >> temp.txt
                echo $line

        fi
done < tmp.txt