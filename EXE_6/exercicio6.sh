#!/bin/bash
# UFCG
# Administraçao de Sistemas
# Exercicio 6
# Maria SUelany Brito da Cruz

# Funçao que imprime relatorio de tempo de envios de pacotes por ping
relatorio(){
	# Remove arquivo
	rm times.txt
	
	# Coloca os tempos em um arquivo
	while read LINE; do
		echo $LINE | cut -d"=" -f4 | cut -d" " -f1 >> times.txt
	done < $1
	
	# Ordena arquivo
	cat times.txt | sort > times_sort.txt
	
	MEIO_ARQ=$(($(cat times.txt | wc -l)/2))
	
	# Mediana
	MEDIANA=$(sed -n "$MEIO_ARQ"p times_sort.txt)
	echo "Mediana dos tempos: $MEDIANA"

	# Media dos 3 maiores tempos
	MAIORES_TEMPOS=$(tail -n 3 times_sort.txt)
	TOTAL=0.0
	
	for TEMPO in $MAIORES_TEMPOS; do
		TOTAL=$( echo "$TOTAL + $TEMPO" | bc )
	done
	
	MEDIA=$(echo "scale=1; $TOTAL/3" | bc)
	echo "Media dos 3 maiores tempos: $MEDIA"
	
	# Funçoes extras
	#Impime maior tempo
	echo "Maior tempo: $(head -n 1 times_sort.txt)"
	
	#Imprime menor tempo
	echo "Menor tempo: $(tail -n 1 times_sort.txt)"
	
}



# Ping (10 pacotes)
# PADRAO 56 BYTES

echo "Ping com pacotes de 56 bytes"
ping -c 10 www.google.com.br | grep "icmp_seq" > packages_sent.txt

relatorio "packages_sent.txt"


#---------------------------------------#
#Imprime linha vazia
echo
#Pausa por 10segundos
sleep 10
#---------------------------------------#

# Ping (10 pacotes)
# 64 BYTES

echo "Ping com pacotes de 64 bytes"
ping -c 10 -s 64 www.google.com.br | grep "icmp_seq" > packages_sent.txt

relatorio "packages_sent.txt"


# Respostas do Exercicio:
# 1- O que representa X, Y, Z em: PING X (Y) Z(W) bytes of data??
# X: O endereço destino para o envio de pacotes
# Y: Ip associado ao endereço X pelo DNS
# Z: Tamanho do pacote

# 2- O que representa A, B, C em: A bytes from B (C): icmp_seq=D ttl=E time=F ms
# A: Tamanho em bytes do pacote
# B: Dominio que o endereço X pertence
# C: Ip associado ao endereço X pelo DNS

# 3- (Bônus) Por que, para X sendo google.com, X e B são diferentes?
# X eh o hostname associado ao ip, nome unico e de facil memorizaçao
# facilita a localizaçao de maquinas pela internet
# B eh o nome dado ao servidor com este dominio   
