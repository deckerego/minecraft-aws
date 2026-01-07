#!/bin/bash

BASEDIR='/opt/minecraft'
MEMORY="1300M"

java "-Xmx$MEMORY" "-Xms$MEMORY" -jar "$BASEDIR/server.jar" nogui