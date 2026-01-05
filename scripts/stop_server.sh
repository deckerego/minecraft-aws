#!/bin/bash

MAINPID=$(systemctl show --property MainPID --value minecraft)

echo "Sending stop command..."
echo "stop" > /run/minecraft.stdin

echo "Waiting for service to finish..."
tail --pid "$MAINPID" -f /dev/null