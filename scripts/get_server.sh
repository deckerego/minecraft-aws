#!/bin/bash
DESTINATION='/opt/minecraft'
TEMP_DIR='.'
USER='minecraft'

id minecraft
if [[ "$?" -ne 0 ]];
    echo "Create minecraft user"
    sudo useradd minecraft
fi

echo "Creating directories"
sudo mkdir -p "$DESTINATION"

MANIFEST=$(curl -s "https://piston-meta.mojang.com/mc/game/version_manifest.json")
LATEST=$(echo "$MANIFEST" | jq -r '.["latest"]["release"]')
echo "Getting metadata for $LATEST"

LATEST_URL=$(echo "$MANIFEST" | jq -r '.["versions"] | map(select(.["id"] == "'"$LATEST"'"))[0] | .["url"]')
METADATA=$(curl -s "$LATEST_URL")
DOWNLOAD_HASH=$(echo $METADATA | jq -r '.["downloads"]["server"]["sha1"]')
DOWNLOAD_URL=$(echo $METADATA | jq -r '.["downloads"]["server"]["url"]')
echo "Downloading $DOWNLOAD_URL"

echo 'eula=true' > "$DESTINATION/eula.txt"
curl -o "$TEMP_DIR/server.jar" "$DOWNLOAD_URL"
CALCULATED_HASH=$(sha1sum "$TEMP_DIR/server.jar")
echo "Verifying $CALCULATED_HASH"

if [[ "$CALCULATED_HASH" = "$DOWNLOAD_HASH  $TEMP_DIR/server.jar" ]]; then
    echo "Updating $DESTINATION/server.jar"
    mv "$TEMP_DIR/server.jar" "$DESTINATION/server.jar"
    sudo chown -R "$USER" "$DESTINATION"
    exit 0
else
    echo "*** INVALID FILE, EXITING ***"
    exit -1
fi