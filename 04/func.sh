#!/bin/bash

function getIP {
        local ip="$(shuf -i 0-255 -n 1)"
        for (( i = 0; i < 3; i++ ))
        do
                ip+=".$(shuf -i 0-255 -n 1)"
        done
        echo $ip
}

function getCODE {
        local code=(200 201 400 401 403 404 500 501 502 503)
        echo ${code[$(shuf -i 0-9 -n 1)]}
}

function getQUERY {
        local query=(GET POST PUT PATCH DELETE)
        echo ${query[$(shuf -i 0-4 -n 1)]}
}

function getAGENT {
        local agent=("Firefox/47.0" "Chrome/51.0.2704.103" "Opera/9.60" "Safari/604.1" "IEMobile/9.0" "Edg/91.0.864.59" "Googlebot/2.1" "PostmanRuntime/7.26.5")
        echo ${agent[$(shuf -i 0-7 -n 1)]}
}

function getURL {
        local url_length=$(shuf -i 6-20 -n 1)
        local html_length=$(shuf -i 8-15 -n 1)
        local url="https://$(cat /dev/urandom | tr -dc '[:alpha:]' | fold -w ${1:-$url_length} | head -n 1).com/$(cat /dev/urandom | tr -dc '[:alpha:]' | fold -w ${1:-$html_length} | head -n 1).html"
        echo $url
}

function getMONTH {
        local output=
        local months=(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)
        if [[ $1 == "" ]]; then
                echo ${months[$(shuf -i 0-11 -n 1)]}
        else
                case $1 in
                        "Jan")output="Feb";;
                        "Feb")output="Mar";;
                        "Mar")output="Apr";;
                        "Apr")output="May";;
                        "May")output="Jun";;
                        "Jun")output="Jul";;
                        "Jul")output="Aug";;
                        "Aug")output="Sep";;
                        "Sep")output="Oct";;
                        "Oct")output="Nov";;
                        "Nov")output="Dec";;
                        "Dec")output="Jan";;
                esac
                echo "$output"
        fi
}

function getDAY {
        local max=
        case $1 in
                "Jan")max=31;;
                "Feb")max=28;;
                "Mar")max=31;;
                "Apr")max=30;;
                "May")max=31;;
                "Jun")max=30;;
                "Jul")max=31;;
                "Aug")max=31;;
                "Sep")max=30;;
                "Oct")max=31;;
                "Nov")max=30;;
                "Dec")max=31;;
        esac
        echo "$(shuf -i 1-$max -n 1)"
}

function checkDAY {
        local max=
        case $1 in
                "Jan")max=31;;
                "Feb")max=28;;
                "Mar")max=31;;
                "Apr")max=30;;
                "May")max=31;;
                "Jun")max=30;;
                "Jul")max=31;;
                "Aug")max=31;;
                "Sep")max=30;;
                "Oct")max=31;;
                "Nov")max=30;;
                "Dec")max=31;;
        esac
        if [ $2 -le $max  ]; then
                echo "OK"
        else
                echo "!!"
        fi
}

function getYEAR {
        echo "$(shuf -i 2010-2023 -n 1)"
}


function addMINUTE {
        local minute=$1
        local hour=$2
        ((minute=minute+1))
        if [ $minute -gt 59 ]; then
                ((minute=0))
                ((hour=hour+1))
        fi
        echo "$minute $hour"
}

function addDAY {
        local day=$1
        local month=$2
        local year=$3
        ((day=day+1))
        local check_day="$(checkDAY $month $day)"
        if [ $check_day == "!!" ]; then
                ((day=1))
                month="$(getMONTH $month)"
                if [[ $month == "Jan" ]]; then
                        ((year=year+1))
                fi
        fi
        echo "$day $month $year"
}