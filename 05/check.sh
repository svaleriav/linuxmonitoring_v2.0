#!/bin/bash

function Unite {
        while read -r line
        do
                echo "$(cat $line)" >> tmp.txt
        done < logs.txt
}