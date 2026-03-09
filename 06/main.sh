#!/bin/bash
path=''../04/''
logs=`find $path -type f -name "*.log" | head -n5`
output="/var/www/goaccess/goaccess.html"

if [[ $logs == "$(echo -e '\n')" ]]; then
	echo "no logfiles present"
	exit
fi

if [[ $1 =~ ^[0-9]+$ ]];then
	 request=$1
else
	echo "Invalid input, numbers only"
	exit
fi

if [[ $request -lt 1 || $request -gt 4 ]]; then
	echo "Your input must be a number between 1 and 4"
	exit
fi

if [[ $request -eq 1 ]]; then
	sudo goaccess $logs -o $output --sort-panel=STATUS_CODES,BY_DATA,ASC -p goaccess.conf \
	--ignore-panel=VISITORS \
	--ignore-panel=REQUESTS \
	--ignore-panel=REQUESTS_STATIC \
	--ignore-panel=OS \
	--ignore-panel=HOSTS \
	--ignore-panel=BROWSERS \
	--ignore-panel=VISIT_TIMES \
	--ignore-panel=REFERRING_SITES \
	--ignore-panel=KEYPHRASES \
	--ignore-panel=REMOTE_USER \
	--ignore-panel=CACHE_STATUS \
	--ignore-panel=GEO_LOCATION \
	--ignore-panel=MIME_TYPE \
	--ignore-panel=TLS_TYPE \
	--ignore-panel=NOT_FOUND

elif [[ $request -eq 2 ]]; then
	sudo goaccess $logs -o $output -p goaccess.conf \
	--ignore-panel=VISITORS \
	--ignore-panel=REQUESTS \
	--ignore-panel=REQUESTS_STATIC \
	--ignore-panel=OS \
	--ignore-panel=BROWSERS \
	--ignore-panel=VISIT_TIMES \
	--ignore-panel=REFERRING_SITES \
	--ignore-panel=KEYPHRASES \
	--ignore-panel=REMOTE_USER \
	--ignore-panel=CACHE_STATUS \
	--ignore-panel=GEO_LOCATION \
	--ignore-panel=MIME_TYPE \
	--ignore-panel=TLS_TYPE \
	--ignore-panel=STATUS_CODES \
	--ignore-panel=NOT_FOUND

elif [[ $request -eq 3 ]]; then
	sudo goaccess $logs -o $output --ignore-status=200 --ignore-status=201 -p goaccess.conf \
	--ignore-panel=VISITORS \
	--ignore-panel=REQUESTS \
	--ignore-panel=REQUESTS_STATIC \
	--ignore-panel=OS \
	--ignore-panel=HOSTS \
	--ignore-panel=BROWSERS \
	--ignore-panel=VISIT_TIMES \
	--ignore-panel=REFERRING_SITES \
	--ignore-panel=KEYPHRASES \
	--ignore-panel=REMOTE_USER \
    	--ignore-panel=CACHE_STATUS \
    	--ignore-panel=GEO_LOCATION \
    	--ignore-panel=MIME_TYPE \
    	--ignore-panel=TLS_TYPE \
    	--ignore-panel=NOT_FOUND

elif [[ $request -eq 4 ]]; then
    	sudo goaccess $logs -o $output --ignore-status=200 --ignore-status=201 -p goaccess.conf \
    	--ignore-panel=VISITORS \
   	--ignore-panel=REQUESTS \
    	--ignore-panel=REQUESTS_STATIC \
	--ignore-panel=OS \
    	--ignore-panel=BROWSERS \
    	--ignore-panel=VISIT_TIMES \
    	--ignore-panel=REFERRING_SITES \
    	--ignore-panel=KEYPHRASES \
    	--ignore-panel=REMOTE_USER \
    	--ignore-panel=CACHE_STATUS \
    	--ignore-panel=GEO_LOCATION \
    	--ignore-panel=MIME_TYPE \
    	--ignore-panel=TLS_TYPE \
    	--ignore-panel=STATUS_CODES \
    	--ignore-panel=NOT_FOUND
fi