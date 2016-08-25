#!/bin/bash

#lista arquivos de saidas(.out) de um exercicio x 
SaidasX(){
	for var in $( ls -a | grep ".out" | grep "$1" ); do
		if [ $(echo $var | cut -d "_" -f2) -eq $1 ]; then
			echo $var
		fi
	done
}

#lista arquivos de entradas(.in) de um exercicio x 
EntradasX(){
	for var in $( ls -a | grep ".in" | grep "$1" ); do
		if [ $(echo $var | cut -d "_" -f2) -eq $1 ]; then
			echo $var
		fi
	done
}

Arquivo_OUT(){
	for var in $(SaidasX "$1"); do
		#echo $var
		parte=$( echo $var | cut -d "_" -f2 )
		parte_dois=$( echo $parte | cut -d "." -f1 )

		if [ $parte -eq $1 ] && [ $parte_dois -eq $2 ]; then
			echo $var
			break
		else
			parte=$( echo $var | cut -d "_" -f2 )
			parte_dois=$( echo $parte | cut -d "." -f1 )
		fi
	done
}


if [ $# -eq 2 ]; then
	
	EXER_SH=$( ls -a | grep "$1" | grep "$2" )
	NUM_EXER=$( echo $1 | cut -d "_" -f2 )
	NOME_DO_EXER=$( echo $EXER_SH | cut -d "." -f1 )
	
	for var in $(EntradasX "$NUM_EXER"); do
			NUM_TESTE=$(echo $var | cut -d "_" -f3 | cut -d "." -f1)
			
			echo $NOME_DO_EXER
			echo "- SAIDA PARA ENTRADA $NUM_TESTE:"
			./$EXER_SH < $var
		
			echo "- DIFERENCA PARA SAIDA ESPERADA:"
			echo $(Arquivo_OUT "$NUM_EXER" "$NUM_TESTE")
			#echo $FILE_OUT
			#diff $(./$EXER_SH < $var) ./$casa
	done
	

elif [ $# -eq 1 ]; then
	
	NUM_EXER=$( echo $1 | cut -d "_" -f2 )
	
	SaidasX "$NUM_EXER"
	EntradasX "$NUM_EXER"

else 
	EXERCICIO=0
	ALUNO=0	
fi



# Caso seu script não receba parâmetros: ele deve testar todos os exercícios com todas as entradas e saídas para todos os alunos da pasta atual. 
# Caso receba apenas EXERCÍCIO como parâmetro, deve testar este exercício de todos os alunos
#  possível especificar a execução de apenas 1 exercício de 1 aluno.

		
#echo $EXERCICIO $ALUNO
