#!/bin/bash

DESTINATION='/opt/minecraft'
MEMORY="1300M"

java "-Xmx$MEMORY" "-Xms$MEMORY" -jar "$DESTINATION/server.jar" nogui