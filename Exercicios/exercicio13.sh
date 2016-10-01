#!/bin/bash
# Administração de Sistemas - UFCG - 2016.1
# Maria Suelany Brito da Cruz Mat.: 115211176
# Exercicio 13


# OBS.: Fiz esse exercicio levando em consideração que o parametro arquivo
#		receberia um nome de um arquivo e não o caminho de um arquivo existente
#		Por isso se o arquivo não existir o script cria um arquivo com o nome passado


if [ $# -eq 3 ]; then

	PARAMETRO=$1
	
	# Parametro -c
	if [ $PARAMETRO = "-c" ]; then
		PALAVRA=$2
		ARQUIVO=$3
		
		QTDE_PALAVRA=$( grep -c $PALAVRA $ARQUIVO )
		if [ $QTDE_PALAVRA -eq 0 ]; then
			echo $PALAVRA >> $ARQUIVO
		else
			echo "A palavra: $PALAVRA já existe no arquivo: $ARQUIVO"
		fi	
	
	# Parametros: -e, -s, -d	
	else
		ARQUIVO=$2
		DIRETORIO=$3
		CAMINHO=$HOME$DIRETORIO$ARQUIVO
		CAMINHO_DIR=$HOME$DIRETORIO
		FIND=$( find $CAMINHO_DIR -name $ARQUIVO )
		
		# Verifica existencia de um arquivo se nao existir cria
		if [ $PARAMETRO = "-e" ]; then
			if [ ! -e $CAMINHO ]; then
				touch $CAMINHO
			else
				echo "Arquivo: $ARQUIVO existe no diretorio: $DIRETORIO"
			fi
		
		# Verifica existencia de um arquivo no diretorio e nos subdiretorios	
		elif [ $PARAMETRO = "-s" ]; then
			if [ -z $FIND ]; then
				touch $ARQUIVO
			else
				echo "Arquivo: $ARQUIVO existe!!" 
				echo "No Caminho: $FIND"
			fi
					
		# Verifica existencia de um arquivo se existir excluir ele	
		elif [ $PARAMETRO = "-d" ]; then
			if [ -e $CAMINHO ]; then
				rm $CAMINHO
			else
				echo "Não existe arquivo com o nome: $ARQUIVO no diretorio: $DIRETORIO"
			fi
		
		# EXTRA
		# remove o arquivo passado como parametro de todos os subdiretorios
		elif [ $PARAMETRO = "-x" ]; then
			if [ -z $FIND ]; then
				echo "Nenhum arquivo nos subdiretorios"
			else
				for caminho in $FIND; do
					rm $caminho
				done
			fi
			
		# Parametro incorreto, ou seja, não é -c, -d, -s, -e
		else
			echo "ERRO: Parametro incorreto"
			exit 1
		fi
	fi

# Outro tipo de parametro
else
	echo "ERRO: Quantidade de parametros errada"
	exit 2
fi
