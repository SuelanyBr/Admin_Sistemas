#!/bin/bash
# UFCG
# Administraçao de Sistemas
# Exercicio 10
# Maria Suelany Brito da Cruz - MAT.: 115211176


ARCHIVE_INITIAL=$1
TYPE_1="CRC"
TYPE_3="MD5"
TYPE_2="SHA1"

while read LINHA; do
	# Colunas de cada linha do arquivo geral
	CHECKSUM=$( echo $LINHA | cut -d" " -f1 )
	TYPE_ALGORITHM=$( echo $LINHA | cut -d" " -f2 )
	ARCHIVE=$( echo $LINHA | cut -d" " -f3- )

	elif [ TYPE_ALGORITHM == TYPE_1 ]; then
			
			
	elif [ TYPE_ALGORITHM == TYPE_2 ]; then
	
	
	elif [ TYPE_ALGORITHM == TYPE_3 ]; then
	
	
	else
	
	
	fi
	
	


done < $ARCHIVE_INITIAL
