#!/bin/bash

source check.sh

path="$1"
folders_num="$2"
folder_letters="$3"
files_num="$4"
file_name_letters="${5%%.*}"
file_ext="${5##*.}"
file_size_kb="${6%kb}"

date_str=$(date +%d%m%y)
log_file="$(pwd)/log_${date_str}.log"
touch "$log_file"


generate_name() {
    local letters="$1"
    local idx="$2"
    local n=${#letters}
    local name=""
    local i

    if [ "$n" -eq 1 ]; then
        for ((i=0; i < 4 + idx; i++)); do name+="${letters:0:1}"; done
    else
        local extra=$(( 4 > n ? 4 - n : 0 ))
        for ((i=0; i < extra + 1; i++)); do name+="${letters:0:1}"; done
        for ((i=1; i < n-1; i++)); do name+="${letters:$i:1}"; done
        for ((i=0; i <= idx; i++)); do name+="${letters:$((n-1)):1}"; done
    fi
    echo "$name"
}

check_space() {
    local free_kb
    free_kb=$(df / | awk 'NR==2 {print $4}')
    if [ "$free_kb" -lt 1048576 ]; then
        echo "Менее 1GB свободного места. Остановка." | tee -a "$log_file"
        exit 1
    fi
}

for ((f=0; f<folders_num; f++)); do
    check_space

    folder_path="${path}/$(generate_name "$folder_letters" $f)_${date_str}"
    mkdir -p "$folder_path"
    echo "DIR  | $folder_path | $(date '+%Y-%m-%d %H:%M:%S')" >> "$log_file"

    for ((i=0; i<files_num; i++)); do
        check_space

        file_path="${folder_path}/$(generate_name "$file_name_letters" $i)_${date_str}.${file_ext}"
        dd if=/dev/zero of="$file_path" bs=1024 count="$file_size_kb" 2>/dev/null
        echo "FILE | $file_path | $(date '+%Y-%m-%d %H:%M:%S') | ${file_size_kb}KB" >> "$log_file"
    done
done

echo "Готово. Лог: $log_file"