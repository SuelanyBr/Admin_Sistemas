#!/bin/bash
# UFCG
# Administraçao de Sistemas - 2016.1
# Exercicio 12
# Maria Suelany Brito da Cruz - Mat.: 115211176

existDirectory(){
	DIR=$1
	QTDE=$( ls | grep $DIR | wc -l)
	echo $QTDE
}

if [ $# -eq 2 ]; then
	ORIGEM=$1
	DESTINO=$2
	
	if [ -d "$ORIGEM" ]; then
		QTDE=$(existDirectory "$ORIGEM")
	fi
	
	NEW_DIR="$ORIGEM.$QTDE"
	mkdir $NEW_DIR
	
	cp -r $ORIGEM $NEW_DIR
	
elif [ $# -eq 3 ]; then
	ORIGEM=$2
	DESTINO=$3
	
	if [ $1 != "-z" ]; then
		echo "Error: parametro incorreto"
	fi
	
else 
	echo "Error: Quantidade de entradas errada"
fi


exit 0
