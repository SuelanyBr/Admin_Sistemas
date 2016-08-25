#!/bin/bash
# UFCG
# Administraçao de Sistemas
# Exercicio 8
# Maria Suelany Brito da Cruz - MAT.: 115211176


verificaHost(){
	#Indique se é um nome válido
	RESULT=$(getent hosts $1)
	if [ $(echo $?) -eq 0 ]; then
	
		#Calcule o número de IPs nas quais cada nome resolve
		IPS=$(getent hosts $1 | wc -l)
		
		#Indique se há um domínio “m”
		DOMINIOS_M=$(getent hosts "m.$1")
		if [ $(echo $?) -eq 0 ]; then
			echo "$1 $IPS MOBILE"
		else
			echo "$1 $IPS"
		fi
		
	else
		echo "$1 ERRO"
	fi
}


if [ $# -eq 2 ] && [ $1 == "-f" ]; then
	# Verifica para cada linha do arquivo
	while read LINE; do
		 verificaHost "$LINE"	
	done < $2
	
elif [ $# -eq 1 ]; then 
	verificaHost "$1"
fi
