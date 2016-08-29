#!/bin/bash
# UFCG
# Administraçao de Sistemas
# Exercicio 9
# Maria Suelany Brito da Cruz - MAT.: 115211176


# Faz requisiçao URL silenciosamente e mostra na ultima linha o tempo total que o processo durou (em milissegundos).
curl -Isw '%{time_total}\n' $1 > ARQUIVO.txt

# Tempo total em Milessimos
ULTIMA_LINHA=$(cat ARQUIVO.txt | wc -l)
RTT=$(sed -n "$ULTIMA_LINHA"p ARQUIVO.txt)
echo "RTT da Requisição HTTP: $RTT ms"

# A hora retornada pelo servidor (formato HH:MM:SS)
HOUR_SERVER=$(cat ARQUIVO.txt | grep "Date" | cut -d" " -f6)
echo "Hora do Servidor: $HOUR_SERVER"

# A hora atual da máquina (formato HH:MM:SS)
HOUR_CLIENT=$(date +%T)
echo "Hora atual da maquina: $HOUR_CLIENT"


# A diferença de tempo entre a hora da máquina e a hora do servidor em segundos
DIFERENCA=$( echo $(( $(date -d"$HOUR_SERVER" +%s) - $(date -d"$HOUR_CLIENT" +%s) )) )
echo "Diferença das horas do servidor e da maquina: $DIFERENCA s"
