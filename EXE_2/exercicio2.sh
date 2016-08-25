#!/bin/bash
# UFCG
# Administraçao de sistemas
# Maria Suelany Brito da Cruz

if [ $# -eq 0 ]; then
    read NUM_OBS
    read TEMPO
    read P_USER
else 
	NUM_OBS=$1
	TEMPO=$2
	P_USER=$3
fi

CONTADOR=0
LINHA_CPU=0

for var in $(seq $NUM_OBS); do
	ps aux > arq
	sleep $TEMPO
	while read line; do
		if [ $(echo $line | cut -d ' ' -f1) = $P_USER ]; then
			LINHA_CPU= echo $line | cut -d ' ' -f3
			CONTADOR=$(($CONTADOR + $LINHA_CPU))
		fi
	done < arq
	echo $CONTADOR >> CONTADOR_CPU
done

echo "$NUM_OBS $TEMPO $P_USER"
