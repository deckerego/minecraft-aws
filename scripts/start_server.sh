#!/bin/bash

BASEDIR='/opt/minecraft'
USER='minecraft'
MEMORY="1300M"

echo 'eula=true' > "$BASEDIR/eula.txt"
sudo chown -R "$USER" "$BASEDIR"
java "-Xmx$MEMORY" "-Xms$MEMORY" -jar "$BASEDIR/server.jar" nogui