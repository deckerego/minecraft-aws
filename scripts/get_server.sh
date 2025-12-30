#!/bin/bash

HASH=64bb6d763bed0a9f1d632ec347938594144943ed

echo 'eula=true' > /opt/minecraft/eula.txt
curl -o /opt/minecraft/server.jar https://piston-data.mojang.com/v1/objects/${HASH}/server.jar
echo "${HASH}  /opt/minecraft/server.jar" | sha1sum -c -