#!/bin/bash

mkdir /var/www/goaccess
sudo apt-get install goaccess nginx -y
sudo cp nginx.conf /etc/nginx/
sudo systemctl restart nginx