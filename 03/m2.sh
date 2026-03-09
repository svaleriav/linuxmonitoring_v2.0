#!/bin/bash

script_dir="$(cd "$(dirname "$0")" && pwd)"

echo "Введите диапазон дат (YYYY-MM-DD HH:MM)"
echo -n "Начальная дата: "
read start_date
echo -n "Конечная дата: "
read end_date

if [[ -z "$start_date" || -z "$end_date" ]]; then
    echo "Ошибка: даты не могут быть пустыми"
    exit 1
fi

tmp_files=$(mktemp)
tmp_dirs=$(mktemp)

sudo find / -maxdepth 100 -type f \
    -newermt "$start_date" ! -newermt "$end_date" \
    ! -path "*/proc/*" \
    ! -path "*/sys/*" \
    ! -path "*/dev/*" \
    ! -path "*/run/*" \
    ! -path "*/snap/*" \
    ! -path "*/bin/*" \
    ! -path "*/sbin/*" \
    ! -path "*/lib/*" \
    ! -path "*/lib64/*" \
    ! -path "*/etc/*" \
    ! -path "*/boot/*" \
    ! -path "*/usr/*" \
    ! -path "${script_dir}/*" \
    2>/dev/null > "$tmp_files"

sudo find / -maxdepth 100 -type d -empty \
    -newermt "$start_date" ! -newermt "$end_date" \
    ! -path "*/proc/*" \
    ! -path "*/sys/*" \
    ! -path "*/dev/*" \
    ! -path "*/run/*" \
    ! -path "*/snap/*" \
    ! -path "*/bin/*" \
    ! -path "*/sbin/*" \
    ! -path "*/lib/*" \
    ! -path "*/lib64/*" \
    ! -path "*/etc/*" \
    ! -path "*/boot/*" \
    ! -path "*/usr/*" \
    ! -path "${script_dir}/*" \
    2>/dev/null > "$tmp_dirs"

echo "Найдено файлов: $(wc -l < "$tmp_files")"
echo "Найдено пустых директорий: $(wc -l < "$tmp_dirs")"
echo -n "Продолжить удаление? (y/N): "
read confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "Отменено"
    rm -f "$tmp_files" "$tmp_dirs"
    exit 0
fi

while read -r line; do
    [[ -z "$line" ]] && continue
    sudo chattr -a "$line" 2>/dev/null
    sudo rm -f "$line"
done < "$tmp_files"

sort -r "$tmp_dirs" | while read -r line; do
    [[ -z "$line" ]] && continue
    sudo rmdir "$line" 2>/dev/null
done

rm -f "$tmp_files" "$tmp_dirs"
echo "Очистка завершена"
