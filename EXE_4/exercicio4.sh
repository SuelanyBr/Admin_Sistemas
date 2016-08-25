#!/bin/bash
# ADMINISTRAÇÃO DE SISTEMAS - 2016.1
# Maria Suelany Brito da Cruz
# EXERCICIO 4

# Joga a segunda saida do comando strace -T em um arquivo
strace -T $* 2> syscalls.txt

# Separa em um arquivo o tempo e a linha do arquivo
CONTADOR=0
while read LINHA; do
	CONTADOR=$(($CONTADOR + 1))
	ELEMENTO=$(echo $LINHA | grep "=" | cut -d "<" -f2 |cut -d ">" -f1)
	echo "$(echo $ELEMENTO) $CONTADOR" >> syscalls_time.txt
done < syscalls.txt


# Ordena os dados em ordem decrescente, exclui todas as linhas que não possui tempo
# E o sed é para pegar as 3 primeiras linhas, joga isso em um arquivo
sort -rk1 syscalls_time.txt | grep "0.0" | sed -n '1,3p' > three_longer_duration.txt


# Imprime linhas que contem as 3 chamadas de maior duraçao 
echo "As 3 chamadas de maior duraçao:"
while read LINHA; do
	NUM_LINHA=$(echo $LINHA | cut -d" " -f2)
	sed -n "$NUM_LINHA"p syscalls.txt
done < three_longer_duration.txt


# Syscall mais chamada
while read LINHA; do
	ELEMENTO=$(echo $LINHA | cut -d "(" -f1)
	echo "$(echo $ELEMENTO)" >> names_syscalls.txt
done < syscalls.txt

# Syscalls sem nomes repetidos
cat names_syscalls.txt | sort | uniq > names_sys.txt

# Verifica qual a syscall mais chamada
SYSCALL=""
MAIOR_CHAMADAS=0

while read LINHA; do
	CHAMADAS_PLV=$( cat names_syscalls.txt | grep "$LINHA" | wc -l )
	if [ $MAIOR_CHAMADAS -lt $CHAMADAS_PLV ]; then
		SYSCALL=$LINHA
		MAIOR_CHAMADAS=$CHAMADAS_PLV
	fi
done < names_sys.txt

echo "Syscall mais chamada: $SYSCALL com $MAIOR_CHAMADAS chamadas" 
