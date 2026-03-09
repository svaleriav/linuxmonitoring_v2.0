#!/bin/bash
source func.sh

if [ $# != 0 ]; then
	echo "Параметры не допускаются"
	exit
fi

month="$(getMONTH)"
day="$(getDAY $month)"
year="$(getYEAR)"
hour=0
minute=0
second=15


for (( i = 0; i < 5; i++ ))
do
        date="$day/$month/$year"
        filename="${day}-${month}-${year}.log"
        touch "$filename"
        if [[ $i -gt 0  ]]; then
                echo "done"
        else
                echo ""
        fi
        echo -n "Заполнение журнала $filename i"
        iter=$(shuf -i 100-1000 -n 1)
        for (( j = 0; j < iter; j++ ))
        do
                echo -n "."
                ttime="$second:$minute:$hour"
                query="$(getQUERY)"
                url="$(getURL)"
                code="$(getCODE)"
                agent="$(getAGENT)"
                ip="$(getIP)"
                echo "$ip - - [${date}:${ttime} +0300] \"${query} ${url}\" ${code} - - \"${agent}\"" >> "$filename"
                tmp="$(addMINUTE $minute $hour)"
                minute="$(echo $tmp | awk '{print $1}')"
                hour="$(echo $tmp | awk '{print $2}')"
        done
        if [ $i -eq 4 ]; then
                echo "done"
                break
        fi
        newdate="$(addDAY $day $month $year)"
        day="$(echo $newdate | awk '{print $1}')"
        month="$(echo $newdate | awk '{print $2}')"
        year="$(echo $newdate | awk '{print $3}')"
done

echo ""
echo "Готово!!! "


#200 - OK
#201 - CREATED
#400 - BAD REQUEST
#401 - UNAUTHORIZED
#403 - FORBIDDEN
#404 - NOT FOUND
#500 - INTERNAL SERVER ERROR
#501 - NOT IMPLEMENTED
#502 - BAD GATEWAY
#503 - SERVICE UNAVAILABLE
#504 - GATEWAY TIMEOUT