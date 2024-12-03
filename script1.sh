#!/bin/bash

link=$1
if [ ${#link} == 0 ]
then
    echo "Exemplo de uso: ./script.sh 192.168.0.1"
else
    echo "============================================"
    echo "[+] Resolvendo URLs em: ${link}"
    echo "============================================"
    linkResponse=$(wget -q -O - "${link}")
    echo "================================================================="
    echo "LINE            IP                   ADDRESS"
    echo "================================================================="
    printf "$linkResponse"
    echo "================================================================="


fi;