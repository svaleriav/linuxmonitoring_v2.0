#!/bin/bash

echo "Введите маску вида: abc_DDMMYY"
echo -n "Маска: "
read mask

# Валидация ввода
if ! [[ "$mask" =~ ^[a-z]+_[0-9]{6}$ ]]; then
    echo "Ошибка. Неверный формат маски. Пример: az_021121"
    exit 1
fi


file_date=$(echo "$mask" | awk -F '_' '{print $2}')
file_abc=$(echo "$mask" | awk -F '_' '{print $1}')
abc_length=${#file_abc}
first_symb="${file_abc:0:1}"

until [ $abc_length -ge 4 ]; do
    file_abc="${first_symb}${file_abc}"
    ((abc_length++))
done

sudo find / -name "${file_abc}*_${file_date}" -type d > tmp.txt


sudo find / -name "${file_abc}*_${file_date}" -type d > tmp.txt

if [ ! -s tmp.txt ]; then
    echo "Ничего не найдено."
    rm -f tmp.txt
    exit 0
fi

echo "Будет удалено:"
cat tmp.txt

echo -n "Продолжить? (y/n): "
read confirm

if [ "$confirm" = "y" ]; then
    while read -r line; do
        sudo rm -rf "$line"
    done < tmp.txt
    echo "Очистка завершена."
else
    echo "Отменено."
fi

rm -f tmp.txt