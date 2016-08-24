#!/bin/bash
# UFCG
# Administraçao de Sistemas
# Exercicio 8
# Maria Suelany Brito da Cruz - MAT.: 115211176


# FUNÇAO QUE IMPRIME RELATORIO DE UM HOST
relatorioHost(){
	# Executa comando guandando o resultado e tempo da execuçao
	(time getent hosts $1 > RESULT 2> /dev/null) 2> times.txt
	
	# Extra: tempo real para fazer consultas
	TIME_REAL=$( cat times.txt | sed -n "2"p | cut -d"m" -f2)
	
	# Numero de IPS que o nome resolve
	IPS=$( cat RESULT | wc -l )
	
	# Nome válido
	if [ $IPS -ne 0 ]; then
	
		#Indique se há um domínio "m"
		DOMINIOS_M=$(getent hosts "m.$1")
		
		# Existe dominios "m"
		if [ $(echo $?) -eq 0 ]; then
			echo "$1 $IPS MOBILE Tempo: $TIME_REAL"
			
		# Nao existe dominios "m"
		else
			echo "$1 $IPS Tempo: $TIME_REAL"
		fi
	
	# Nome invalido	
	else
		echo "$1 ERRO Tempo: $TIME_REAL"
	fi
}

# VERIFICA ENTRADA E CHAMA FUNÇAO QUE IMPRIME RELATORIO PARA CADA HOST
if [ $# -eq 2 ] && [ $1 == "-f" ]; then
	# Verifica para cada linha do arquivo
	while read LINE; do
		 relatorioHost "$LINE"	
	done < $2
	
elif [ $# -eq 1 ]; then 
	relatorioHost "$1"
fi

