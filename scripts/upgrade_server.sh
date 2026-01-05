#!/bin/bash
DESTINATION='/opt/minecraft'
USER='minecraft'

MANIFEST=$(curl -s "https://piston-meta.mojang.com/mc/game/version_manifest.json")
LATEST=$(echo "$MANIFEST" | jq -r '.["latest"]["release"]')
echo "Getting metadata for $LATEST"

LATEST_URL=$(echo "$MANIFEST" | jq -r '.["versions"] | map(select(.["id"] == "'"$LATEST"'"))[0] | .["url"]')
METADATA=$(curl -s "$LATEST_URL")
DOWNLOAD_HASH=$(echo $METADATA | jq -r '.["downloads"]["server"]["sha1"]')
DOWNLOAD_URL=$(echo $METADATA | jq -r '.["downloads"]["server"]["url"]')
echo "Downloading $DOWNLOAD_URL"

curl -o "$DESTINATION/server.tmp" "$DOWNLOAD_URL"
CALCULATED_HASH=$(sha1sum "$DESTINATION/server.tmp")
echo "Verifying $CALCULATED_HASH"

if [[ "$CALCULATED_HASH" = "$DOWNLOAD_HASH  $DESTINATION/server.tmp" ]]; then
    echo "Updating $DESTINATION/server.jar"
    mv "$DESTINATION/server.tmp" "$DESTINATION/server.jar"
    echo 'eula=true' > "$DESTINATION/eula.txt"
    sudo chown -R "$USER" "$DESTINATION"
    exit 0
else
    echo "*** INVALID FILE, EXITING ***"
    exit -1
fi