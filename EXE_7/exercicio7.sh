#!/bin/bash
# UFCG
# Administraçao de Sistemas
# Exercicio 7
# Maria SUelany Brito da Cruz - MAT.: 115211176


# IF - Um parametro: executar o resultado para cada linha do arquivo
# ELIF - Dois parametro: Imprimir resultado e verificar se contem palavras
# ELSE - Nenhum ou mais de dois parametros

if [ $# -eq 1 ]; then
	#Imprime resultados de requisiçoes
	while read LINE; do 
		RESULT=$(curl -Is $LINE | grep "HTTP" | cut -d" " -f2) 
		echo "$LINE $RESULT"
	done < $1 

elif [ $# -eq 2 ]; then
	#Imprime resultados e verifica se todas as palavras estao contidas na pagina
	while read LINE; do 
		curl -Is $LINE > requisicao
		RESULT=$(cat requisicao | grep "HTTP" | cut -d" " -f2) 
		
		curl -s $LINE > pagina.html 
		
		#Quantidade de palavras que contem no html
		CONTAINS=0
		while read PALAVRA; do
			if [ "$(grep $PALAVRA pagina.html)" ]; then
				CONTAINS=$(($CONTAINS + 1))
			fi
		done < $2
		
		if [ $CONTAINS -eq $(cat $2 | wc -l) ]; then
			echo "$LINE $RESULT OK"
		else
			echo "$LINE $RESULT"
		fi
		
		# EXTRA: Data em que foi feita o download		
		cat requisicao | grep "Date"
		
	done < $1 
else
	echo "A quantidade aceitavel de parametros eh 1 ou 2 arquivos de texto"
fi


