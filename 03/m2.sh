#!/bin/bash

echo "Введите диапазон дат (YYYY-MM-DD HH:MM)"
echo -n "Начальная дата: "
read start_date
echo -n "Конечная дата: "
read end_date
sudo find / -maxdepth 100 -newermt "$start_date" ! -newermt "$end_date" > tmp.txt
while read -r line; do
    if ! [[ $line == *"/DO4_LinuxMonitoring_v2.0-1/"* ]]; then
        sudo chattr -a "$line"
        sudo rm -rf "$line"
    fi
done < tmp.txt
rm -f tmp.txt
echo "Очистка завершена"