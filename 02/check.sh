#!/bin/bash

err=0

if [ $# != 3 ];
then
        err=1
else
        declare -x fold_name=$1
        declare -x fold_name_length=`expr "$fold_name" : '.*'`
        declare -x file_name_ext=$2
        declare -x file_name="$(echo $file_name_ext | cut -d. -f1)"
        declare -x file_name_length=`expr "$file_name" : '.*'`
        declare -x file_extension="${5##*.}"
        declare -x file_extension_length=`expr "$file_extension" : '.*'`
        declare -x file_size=`echo $3 | egrep -o ^[0-9+$]*`
        if [[ $fold_name_length -le 7 ]] && [[ $fold_name =~ ^[a-z]+$ ]]; then
                :
        else
                err=4
        fi
        if [[ $file_name_ext =~ ^[a-z]+[.]+[a-z]+$ ]]; then
                if [[ $file_name_length -le 7 && $file_extension_length -le 3 ]]; then
                        :
                else
                        err=6
                fi
        else
                err=6
        fi
        if [[ $file_size -le 0 ]] || [[ $file_size -gt 100 ]]; then
                err=7
        else
                :
        fi
fi
echo $err