#!/bin/bash

echo "Введите маску вида: *abc*_DDMMYY"
echo -n "Маска: "
read mask
file_date=$(echo "$mask" | awk -F '_' '{print $2}')
file_abc=$(echo "$mask" | awk -F '_' '{print $1}')
abc_length=${#file_abc}
last_symb="${file_abc: -1}"
until [ $abc_length -ge 5 ]; do
    file_abc+="$last_symb"
    ((abc_length++))
done
sudo find / -name "${file_abc}*_${file_date}" -type d > tmp.txt
while read -r line; do
    sudo rm -rf "$line"
done < tmp.txt
rm -f tmp.txt
echo "Очистка завершена"