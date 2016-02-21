#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd );
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
if $(testcommand websocketd)
then
	ok "websocketd allready installed!"
else
	sudo cp "$DIR"/websocketd_arm/websocketd /usr/bin/websocketd
	if $(testcommand websocketd)
        then
                ok "websocketd  setup complete!"
        else
                poop "websocetd setup failed!"
        fi

fi
if $(testcommand rabbitmq-server)
then
	ok "rabbitMQ server allready installed!"
else 
	deb http://www.rabbitmq.com/debian/ testing main
	wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
	sudo apt-key add rabbitmq-signing-key-public.asc
	rm rabbitmq-signing-key-public.asc
	sudo apt-get install rabbitmq-server
	[ ! -f /etc/rabbitmq/rabbitmq.config ] && sudo cp "$DIR"/setupfiles/rabbitmq.config /etc/rabbitmq/rabbitmq.config;
	sudo service rabbitmq-server restart
	if $(testcommand rabbitmq-server)
	then
		ok "rabbitMQ server  setup complete!"
	else
		poop "rabbitMQ server setup failed!"
	fi
fi

if $(testcommand git)
then
        ok "git allready installed!"
else
        sudo apt-get install git-core
        if $(testcommand git)
        then
                ok "git setup complete!"
        else
                poop "git setup failed!"
        fi
fi

if $(testcommand pip)
then
	ok "pip allready installed!"
else
	sudo apt-get install python-setuptools
	sudo easy_install pip
	if $(testcommand pip)
	then
		ok "pip setup complete!"
	else
		poop "pip setup failed!"
	fi
fi
#reinstall to avoid version mismatch 
sudo pip install pika==0.9.8
#echo "now we will test if everything works fine..."
#./startExample
