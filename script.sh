#!/bin/bash

link=$1
if [ ${#link} == 0 ]
then
    echo "Exemplo de uso: ./script.sh exemplo.com.br"
else
    listadedominios=""
    echo "============================================"
    echo "[+] Resolvendo URLs em: ${link}"
    echo "============================================"
    linkResponse=$(wget -q -O - "${link}")
    host=$(echo $linkResponse | grep -oP 'href="\K[^"]+')
    httpLinks=$(echo "$host" | grep -oP 'http[s]?://[^ ]+' | uniq -ui)
    cont=1
    for link in $httpLinks; do
      dominio=$(echo  "$link" | cut -d'/' -f3 | cut -d":" -f1  | sed 's/^https\?:\/\///' | sed 's/^www\.//' )
      echo $dominio
      linkunico=$(ping -c1 $dominio)
      ip=$(echo $linkunico | grep "$dominio"|  cut -d "(" -f2 | cut -d ")" -f1)
      listadedominios+="$cont          $ip          $dominio"$'\n'
      ((cont++))
    done
    echo "================================================================="
    echo "LINE            IP                   ADDRESS"
    echo "================================================================="
    printf "$listadedominios"
    echo "================================================================="


fi;