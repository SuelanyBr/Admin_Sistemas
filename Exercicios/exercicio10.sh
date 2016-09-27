#!/bin/bash
# UFCG
# Administraçao de Sistemas
# Exercicio 10
# Maria Suelany Brito da Cruz - MAT.: 115211176


ARCHIVE_INITIAL=$1

type_default(){
	FILE=$1
	OLD_CHECKSUM=$2
	
	CHECKSUM_1=$( cksum $FILE | cut -d" " -f1 )
	CHECKSUM_2=$( md5sum $FILE | cut -d" " -f1 )
	CHECKSUM_3=$( sha1sum $FILE | cut -d" " -f1 )
			
	RETURN=""
	if [ $CHECKSUM_1 == $OLD_CHECKSUM ]; then
		RETURN=$CHECKSUM_1
		
	elif [ $CHECKSUM_2 == $OLD_CHECKSUM ]; then
		RETURN=$CHECKSUM_2
		
	elif [ $CHECKSUM_3 == $OLD_CHECKSUM ]; then
	 	RETURN=$CHECKSUM_3
	 	
	else
		RETURN="NOT_FOUND $FILE"
	fi	
	echo "$RETURN"
}

while read LINE; do

	# Colunas de cada linha do arquivo geral
	CHECKSUM=$( echo $LINE | cut -d" " -f1 )
	TYPE_ALGORITHM=$( echo $LINE | cut -d" " -f2 )
	FILE=$( echo $LINE | cut -d" " -f3- )

	# Testa existencia de um arquivo
	if [ -f "$FILE" ]; then
		
		NEW_CHECKSUM=""
		
		# Gera nova checagem a partir do algoritmo passado como parametro
		case $TYPE_ALGORITHM in
		
			"CRC") NEW_CHECKSUM=$( cksum $FILE | cut -d" " -f1 ) ;;
			
			"MD5") NEW_CHECKSUM=$( md5sum $FILE | cut -d" " -f1 ) ;;
			
			"SHA1") NEW_CHECKSUM=$( sha1sum $FILE | cut -d" " -f1);;
			
			# Testa para todos os outros algoritmos
			*) NEW_CHECKSUM=$(type_default "$FILE" "$CHECKSUM") ;;
		esac
		
		# Compara os valores das checagens
		if [ "$CHECKSUM" == "$NEW_CHECKSUM" ]; then
			echo "OK $FILE --- Checagem: $NEW_CHECKSUM" 
		else
			echo "NOT_FOUND $FILE"
		fi
	
	# Se arquivo nao existe		
	else
		echo "ERROR: $FILE NOT EXIST"
	
	fi	

done < $ARCHIVE_INITIAL
