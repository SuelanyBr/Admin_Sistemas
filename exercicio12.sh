#!/bin/bash
# UFCG
# Administraçao de Sistemas - 2016.1
# Exercicio 12
# Maria Suelany Brito da Cruz - Mat.: 115211176

existDirectory(){
	DIR=$1
	QTDE=0
	
	if [ -d $DIR ]; then
		echo $QTDE;
	else
		for doc in $(ls); do
			QTDE=$(( $QTDE + 1 ))
			if [ "$doc" = "$DIR.$QTDE" ]; then
				echo $QTDE
			fi
		done	
	fi
	
}

if [ $# -eq 2 ]; then
	ORIGEM=$1
	DESTINO=$2
	
	existDirectory "$ORIGEM"
	
	
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
