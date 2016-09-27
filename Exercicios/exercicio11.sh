#!/bin/bash
# Adiministraçao de Sistemas - 2016.1
# Exercicio 11
# Maria Suelany Brito da Cruz - Mat.: 11521176

# Parametro recebido
SERVER=$1

# Baixa arquivos que estao no server
# -r --> Recursivo
# -q --> nao imprime enquanto estiver executando
# -nd --> nao baixa diretorios
wget -r -q -nd $SERVER


# Exclui arquivos index
find . -iname 'index.html*' -exec rm {} \;
