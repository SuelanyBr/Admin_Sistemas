#!/bin/bash
# UFCG
# Administraçao de Sistemas - 2016.1
# Exercicio 12
# Maria Suelany Brito da Cruz - Mat.: 115211176

if [ $# -eq 2 ]; then
	ORIGEM=$1
	DESTINO=$2
	
	if [ -d "$ORIGEM" ]; then
		QTDE=$( ls -d */ | grep $ORIGEM | wc -l)
		NEW_DIR="$ORIGEM.$QTDE"
	else
		NEW_DIR="$ORIGEM"
	fi
	
	cp -r $ORIGEM $NEW_DIR
	
elif [ $# -eq 3 ]; then
	ORIGEM=$2
	DESTINO=$3
	
	if [ $1 != "-z" ]; then
		echo "Error: parametro incorreto"
		exit 1
	fi
	
else 
	echo "Error: Quantidade de entradas errada"
	exit 1
fi

exit 0
