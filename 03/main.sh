#!bin/bash


if [[ $# != 0  ]]; then
	echo "Не вводите параметры"
	exit
fi

echo "Выберите метод очистки:"
echo "1 - По лог файлу"
echo "2 - По дате и времени создания"
echo "3 - По маске имени"
echo -n ": "
read answer
if ! [[ $answer =~ ^[1-3]+$ ]]; then
	echo "Введите номер от 1 до 3"
	exit
fi

case $answer in
	1) bash m1.sh;;
	2) bash m2.sh;;
	3) bash m3.sh;;
esac