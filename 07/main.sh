#!/bin/bash

if [ $# -gt 0 ]; then
	echo "No parameters allowed"
	exit
fi

timeout 30s sudo bash ../02/main.sh az az.az 2MB
echo "Check the results on grafana dashboard and don't forget to clean the system using script from part 3!"
echo -n "Do you wish to continue? [Y/n]:"
read answer
if [[ $answer != 'Y' && $answer != 'y' ]]; then
	exit
fi
stress -c 2 -i 1 -m 1 --vm-bytes 32M -t 1m
echo "Check the stats on the dashboard again and good luck"