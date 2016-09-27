#!/bin/bash
#UFCG
#Administração de Sistemas
#Maria Suelany Brito da Cruz


ARQUIVO=$(grep --binary-files=text ' - -' ./access_log | cut -d ' ' -f1)

# Conta quantidade de linha com as palavras: LOCAL e REMOTE
CONTADOR_LOCAL=$(grep --binary-files=text ' - -' ./access_log | grep -c "local")
CONTADOR_REMOTE=$(grep --binary-files=text ' - -' ./access_log | grep -c "remote")

echo "Requisições Locais: $CONTADOR_LOCAL "  
echo "Requisições Remotas: $CONTADOR_REMOTE"


# contagem de horas locais
grep --binary-files=text 'local - -' ./access_log | cut -d ':' -f2 > new_log

HORA_LOCAL=0
while read line; do
	HORA_LOCAL=$(( $HORA_LOCAL + 10#$line ))
done < "new_log"

MEDIA_HORA_LOCAL=$(( $HORA_LOCAL / $CONTADOR_LOCAL ))
echo "Hora em media das requisições locais: $MEDIA_HORA_LOCAL hs"



# contagem de horas remote
grep --binary-files=text 'remote - -' ./access_log | cut -d ':' -f2 > new_log

HORA_REMOTE=0
while read line; do
	HORA_REMOTE=$(( $HORA_REMOTE + 10#$line ))
done < "new_log"


MEDIA_HORA_REMOTE=$(( $HORA_REMOTE/ $CONTADOR_REMOTE ))
echo "Hora em media das requisições remotas: $MEDIA_HORA_REMOTE hs"

#requisiçoes mais realizadas
if [ $CONTADOR_LOCAL -gt $CONTADOR_REMOTE ]; then
	echo "Requisições mais realizadas foram as locais"
else
	echo "Requisições mais realizadas foram as remotas"
fi
