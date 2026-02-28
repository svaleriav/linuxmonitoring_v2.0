#!/bin/bash

echo -n "Введите путь к лог-файлу: "
read path
if ! [[ -f $path ]]; then
    echo "Лог-файл не существует"
    exit 1
fi
while read -r line; do
    type=$(echo "$line" | awk '{print $1}')
    pathing=$(echo "$line" | awk '{print $3}')
    if [[ "$type" == "DIR" ]]; then
        rm -rf "$pathing"
    elif [[ "$type" == "FILE" ]]; then
        rm "$pathing"
    fi
done < "$path"
echo "Очистка завершена"