#!/bin/bash -x
sudo apt-get update -y
sudo apt-get install apt-transport-https wget gnupg -y
sudo wget -O - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo echo 'deb https://artifacts.elastic.co/packages/7.x/apt stable main' | sudo tee -a /etc/apt/sources.list.d/elasticsearch.list
sudo apt-get update -y
sudo apt-get install elasticsearch -y
sudo echo "network.host: 0.0.0.0" | sudo tee -a /etc/elasticsearch/elasticsearch.yml
sudo echo "http.port: 9200" | sudo tee -a /etc/elasticsearch/elasticsearch.yml
sudo echo "xpack.security.enabled: true" | sudo tee -a /etc/elasticsearch/elasticsearch.yml
sudo echo "discovery.type: single-node" | sudo tee -a /etc/elasticsearch/elasticsearch.yml
sudo systemctl start elasticsearch
sudo chmod 777 -R /etc/default/elasticsearch
sudo chmod 777 -R /etc/elasticsearch
printf 'y' | /usr/share/elasticsearch/bin/elasticsearch-setup-passwords auto
sudo systemctl stop elasticsearch
sudo chmod 777 -R /usr/share/elasticsearch
printf '\n\n' | /usr/share/elasticsearch/bin/elasticsearch-certutil  ca
printf '\n\n' | /usr/share/elasticsearch/bin/elasticsearch-certutil cert
sudo cp /usr/share/elasticsearch/elastic-certificates.p12 /etc/elasticsearch/
printf '\n\n\n\n\n\n\n\n\n\n\n\n\n' | /usr/share/elasticsearch/bin/elasticsearch-certutil  http
sudo apt install unzip
unzip /usr/share/elasticsearch/elasticsearch-ssl-http.zip 
sudo sleep 5
sudo cp elasticsearch/http.p12 /etc/elasticsearch/
sudo echo "xpack.security.http.ssl.enabled: true" | sudo tee -a /etc/elasticsearch/elasticsearch.yml
sudo echo "xpack.security.http.ssl.keystore.path: "http.p12"" | sudo tee -a /etc/elasticsearch/elasticsearch.yml
sudo echo "xpack.security.transport.ssl.enabled: true" | sudo tee -a /etc/elasticsearch/elasticsearch.yml
printf '\n' | /usr/share/elasticsearch/bin/elasticsearch-keystore add xpack.security.http.ssl.keystore.secure_password
sudo systemctl start elasticsearch