#!/bin/sh
deb http://www.rabbitmq.com/debian/ testing main
wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
sudo apt-key add rabbitmq-signing-key-public.asc
rm rabbitmq-signing-key-public.asc
sudo apt-get install rabbitmq-server
sudo cp ./setupfiles/rabbitmq.config /etc/rabbitmq/rabbitmq.config
sudo service rabbitmq-server restart
sudo pip install pika==0.9.8
echo "now we will test if everything works fine..."
./startExample
