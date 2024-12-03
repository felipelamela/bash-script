#!/bin/bash

rede=$1
porta=$2


if [[ -z "$rede" || -z "$porta" ]]; then
    echo "Modo de uso: ./scan.sh 192.168.0 80"
    exit 1
else
    echo "Iniciando o scan na rede $rede na porta $porta"
    
    for ip in {1..254}; do
        sudo hping3 -S -p $porta -c 1 $rede.$ip 2>/dev/null | grep "flags=SA" | cut -d " " -f2 | cut -d "=" -f2
    done
    exit 0

fi