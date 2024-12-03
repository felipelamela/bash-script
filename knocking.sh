#!/bin/bash

SEQUENCIA=("13" "37" "30000" "3000" "1337")
PROGRESSO=0
IP_CLIENTE="37.59.174.235"
LOG="/tmp/knock.log"

enviar_pacotes() {
    echo "Enviando pacotes..."
    # for PORTA in "${SEQUENCIA[@]}"; do
    #     echo "Enviando para porta $PORTA..."
    #     sudo hping3 -S -p $PORTA $IP_CLIENTE -c 1
    #     sleep 1 
    # done

    sudo hping3 -S -p 30000 $IP_CLIENTE -c 1
    echo ""
    echo ""
    sudo hping3 -S -p 1337 $IP_CLIENTE -c 1
}172.16.1.55

monitorar_pacotes() {
    echo "Monitorando pacotes..."
    sudo tcpdump -n -i eth0 port "${SEQUENCIA[@]}" > $LOG &
    MONITOR_PID=$!
}

verificar_sequencia() {
    ULTIMO_LOG=$(tail -n 1 $LOG)

    # Verifica se o IP e a porta correspondem à próxima na sequência
    if echo "$ULTIMO_LOG" | grep -q "SRC=$IP_CLIENTE DPT=${SEQUENCIA[$PROGRESSO]}"; then
        echo "Porta correta: ${SEQUENCIA[$PROGRESSO]}"
        ((PROGRESSO++))
    else
        # Porta inesperada: reinicia a sequência
        echo "Sequência inválida, reiniciando..."
        PROGRESSO=0
    fi

    # Verifica se a sequência foi completada
    if [ $PROGRESSO -eq ${#SEQUENCIA[@]} ]; then
        liberar_acesso
    fi
}

liberar_acesso() {
    echo "Sequência correta! Acesso liberado à porta 1337."
    iptables -I INPUT -s "$IP_CLIENTE" -p tcp --dport 1337 -j ACCEPT
    kill $MONITOR_PID
    exit 0
}

# Início do script
# monitorar_pacotes
enviar_pacotes