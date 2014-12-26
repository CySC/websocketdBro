#!/bin/sh
sudo rpm --import http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
sudo yum install rabbitmq-server--1.noarch.rpm
sudo cp ./rabbitmq.config /etc/rabbitmq/rabbitmq.config
sudo pip install pika==0.9.8
echo "now we will test if everything works fine..."
./startExample
