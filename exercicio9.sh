#!/bin/bash
# UFCG
# Administraçao de Sistemas
# Exercicio 9
# Maria Suelany Brito da Cruz - MAT.: 115211176


# Faz requisiçao URL silenciosamente e mostra na ultima linha o tempo total que o processo durou (em milissegundos).
curl -Isw '%{time_total}\n' #"URL" > Arquivo

#Tempo total em Milessimos
ULTIMA_LINHA=$(cat TESTE.txt | wc -l)
sed -n "$ULTIMA_LINHA"p TESTE.txt 

#A hora retornada pelo servidor (formato HH:MM:SS)
cat Arquivo | grep "Date" | cut -d" " -f6

#A hora atual da máquina (formato HH:MM:SS)
date +%T

#A diferença de tempo entre a hora da máquina e a hora do servidor em segundos
