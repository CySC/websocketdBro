#!/bin/sh
testcommand()
{
 	if [ -z "$(command -v $1)" ]
 	then 
  		return 1 #failure nothing returned
 	else
  		return 0 #succes location returned and command works
 	fi
}
ok(){
	echo -e "[ \e[1;32m 0K \e[0m ] $1"
}
poop(){
	echo -e "[ \e[1;31 FAILED \e[0m ] $1"
}
if $(testcommand rabbitmq-server)
then
	ok "rabbitMQ server allready installed!"
else 
	deb http://www.rabbitmq.com/debian/ testing main
	wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
	sudo apt-key add rabbitmq-signing-key-public.asc
	rm rabbitmq-signing-key-public.asc
	sudo apt-get install rabbitmq-server
	sudo cp ./setupfiles/rabbitmq.config /etc/rabbitmq/rabbitmq.config
	sudo service rabbitmq-server restart
	if $(testcommand rabbitmq-server)
	then
		ok "rabbitMQ server  setup complete!"
	fi
fi
sudo pip install pika==0.9.8
#echo "now we will test if everything works fine..."
#./startExample
