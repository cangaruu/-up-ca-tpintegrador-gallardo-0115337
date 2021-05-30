#!/bin/bash

DIR="/home/user-file-server"

if [ -d "$DIR/logs/" ]; then
	echo "El directorio 'logs' ya ha sido creado"
else
	echo "Creando directorio 'logs'"
	mkdir $DIR/logs
fi

# Chequear si la maquina 03 esta ON

ping -c2 192.168.20.3
if [ $? -eq 0 ]; then
	LOG_FILE="$0_$(date -u +'Y%-%m-%d_%H-%M-%SZ').log"
	rsync -avzrh --stats --exclude '.cache' --delete --no-perms -e ssh cliente@192.168.20.3:/home/ /media/disco_backups/ --log-file=$LOG_FILE
else
	LOG_FILE=$0_$(date -u +'Y%-%m-%d_%H-%M-%SZ').log"
	echo "La maquina remota no se encuentra disponible" > $LOG_FILE
fi

mv $LOG_FILE $DIR/logs/

exit 0