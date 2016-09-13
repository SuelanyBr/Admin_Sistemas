#!/bin/bash
# UFCG
# Administraçao de Sistemas
# Exercicio 10
# Maria Suelany Brito da Cruz - MAT.: 115211176


ARCHIVE_INITIAL=$1


type_default(){
	FILE=$1
	OLD_CHECKSUM=$2
	echo "$FILE	$OLD_CHECKSUM"
	
	
	CHECKSUM_1=$( cksum $FILE | cut -d" " -f1 )
	CHECKSUM_2=$( md5sum $FILE | cut -d" " -f1 )
	CHECKSUM_3=$( sha1sum $FILE | cut -d" " -f1 )
			
	if [ "$CHECKSUM_1" == "$OLD_CHECKSUM" ]; then
		echo $CHECKSUM_1
		
	elif [ "$CHECKSUM_2" == "$OLD_CHECKSUM" ]; then
		echo $CHECKSUM_2
		
	elif [ "$CHECKSUM_3" == "$OLD_CHECKSUM" ]; then
	 	echo $CHECKSUM_3
	 	
	else
		echo "NOT_FOUND $FILE"
	
	fi	
}

while read LINHA; do
	# Colunas de cada linha do arquivo geral
	CHECKSUM=$( echo $LINHA | cut -d" " -f1 )
	TYPE_ALGORITHM=$( echo $LINHA | cut -d" " -f2 )
	FILE=$( echo $LINHA | cut -d" " -f3- )

	# Testa existencia de um arquivo
	if [ -f "$FILE" ]; then
		
		NEW_CHECKSUM=""
		
		# Gera nova checagem a partir do algoritmo passado como parametro
		case $TYPE_ALGORITHM in
		
			"CRC") NEW_CHECKSUM=$( cksum $FILE | cut -d" " -f1 ) ;;
			
			"MD5") NEW_CHECKSUM=$( md5sum $FILE | cut -d" " -f1 ) ;;
			
			"SHA1") NEW_CHECKSUM=$( sha1sum $FILE | cut -d" " -f1);;
			
			# Testa para todos os outros algoritmos
			*) NEW_CHECKSUM= type_default "$FILE $CHECKSUM" ;;
		esac
		
		# Compara os valores das checagens
		echo $NEW_CHECKSUM
		if [ "$CHECKSUM" == "$NEW_CHECKSUM" ]; then
			echo "OK $FILE" 
		else
			echo "NOT_FOUND $FILE"
		fi
	
	# Se arquivo nao existe		
	else
		echo "ERROR: $FILE NOT EXIST"
	
	fi	


done < $ARCHIVE_INITIAL
