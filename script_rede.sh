#!/bin/bash
rede=$1
if [ $rede == "" ]
then
    echo "Exemplo: $0 192.168.0 "
else 
  hostsExists=""
  hostsNotExists=""

  host=$(echo $rede | cut -d "." -f1,2,3)

  echo "Analizando rede: $host"
  cont=0
  for hostlooping in {1..254}
  do
    ping  -c 1 $host.$hostlooping | grep "64 bytes" | cut -d " " -f4

  done

fi