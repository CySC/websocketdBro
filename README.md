#websocketdBro
####A wobsocketd broadcaster based on AMQ and webocketd.

 WebsocketdBro extends websocketd so that we can run only one instance of the script and broadcast the results to all the clients that connectto the websocketd server, an issue that attracted a lot of dicussion in websocketd's official repo. 
##Installation
If you are using raspbian(or any kind of debian system using arm architecture) simply run:
```raspbian_setup.sh ```

(asuming  that pip and python are already installed)

Warning: if you have rabbitMQ  already installed it would be better to setup manually, skiping the part that setups rabbitmq configuration(to avoid overwriting).
##Flags
###-m: Mode
The first version of websocketdBro accepts two modes, "publisher" and "consumer".

###-e: Exchange Name (optional-default name: "default")
The exchange name used to publish/consume messages. If you wish your publisher to publish to the example exchange and a conumer to consume from that you need to specify that name in both cases using the -e flag (-e exchange).
If you are not usig any other exchanges on your system then it is safe to ommit the flag and they will both use the "default" exchange, but we do not recommend this practice.
###Example Usage
```sh
    ./bro -m consumer -e example
    mypubscript | ./bro -m publisher -e example  
```
The first command will start the websockedBro consumer. In this phase you sould be able to  connect to the websocketd server which will send a message to your websocket cient as soon as it receives a message from a publisher.

The second command is used to pipe the stdout of your script to the bro publisher so that you can see it in your browser connected to websocketd

###Working Example
If you have mplayer installed you can run the ```./startExample``` script which will show you the output of running mplayer in midori. I added that example for the sake of simplicity as that was what I was trying to achieve. In the future I will add more simple examples with less dependencies to get you started. If you don't have mplayer follow the instructhons and simply echo something to the publisher to test it :

eg. ```echo test | ./bro -m publisher -e example```

