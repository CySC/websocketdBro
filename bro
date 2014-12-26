#!/bin/bash
mode=none
exchange=default
exchange=""
routing_key="";
while getopts :m:e:k opt; do
  case $opt in
    m)
      mode=$OPTARG
      ;;
    e)
      exchange=$OPTARG
     ;;
    k)
      routing_key=$OPTARG
     ;;
    \?)
      echo "Invalid flag: -$OPTARG" >&2
      exit 1;
      ;;
  esac
done
if [ $mode == "publisher" ];
then
	./websocketdBro/"$mode".py $exchange $rooting_key
fi
if [[ $mode == "consumer" ]];
then
	 websocketd --port=7777 ./websocketdBro/"$mode".py $exchange $rooting_key
fi
