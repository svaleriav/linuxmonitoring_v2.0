#!/bin/bash
#grafana port - 3000
#prometheus port - 9090

#updating packages
sudo apt update
sudo apt upgrade

#installing prometheus
sudo apt-get install prometheus -y

#installing grafana
sudo snap install grafana

#installing node_exporter
wget https://github.com/prometheus/node_exporter/releases/download/v1.2.2/node_exporter-1.2.2.linux-amd64.tar.gz
tar xvfz node_exporter-1.2.2.linux-amd64.tar.gz
rm node_exporter-1.2.2.linux-amd64.tar.gz

#installing stress
sudo apt-get install -y stress

#creating a node_exporter service
sudo echo -e "[Unit]\nDescription=Node Exporter\nWants=network-online.target\nAfter=network-online.target\n\n[Service]\nUser=$(whoami)\nGroup=sudo\nType=simple\nExecStart=$(pwd)/node_exporter-1.2.2.linux-amd64/node_exporter\n\n[Install]\nWantedBy=default.target" > /etc/systemd/system/node_exporter.service

#updating
sudo apt update

#enabling everything
sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl start prometheus