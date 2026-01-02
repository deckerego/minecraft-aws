#!/bin/bash
DESTINATION='/opt/minecraft'
TEMP_DIR='.'

MANIFEST=$(curl -s https://piston-meta.mojang.com/mc/game/version_manifest.json)
LATEST=$(echo "$MANIFEST" | jq -r '.["latest"]["release"]')
echo "Getting metadata for $LATEST"

LATEST_URL=$(echo "$MANIFEST" | jq -r '.["versions"] | map(select(.["id"] == "'"$LATEST"'"))[0] | .["url"]')
echo $LATEST_URL
METADATA=$(curl -s "$LATEST_URL")
DOWNLOAD_HASH=$(echo $METADATA | jq -r '.["downloads"]["server"]["sha1"]')
DOWNLOAD_URL=$(echo $METADATA | jq -r '.["downloads"]["server"]["url"]')
echo "Downloading $DOWNLOAD_URL"

echo 'eula=true' > "$DESTINATION/eula.txt"
curl -o "$TEMP_DIR/server.jar" "$DOWNLOAD_URL"
echo "Verifying $HASH"
CALCULATED_HASH=$(sha1sum "$TEMP_DIR/server.jar")

if [[ "$CALCULATED_HASH" = "$DOWNLOAD_HASH  $TEMP_DIR/server.jar" ]]; then
    echo "Updating $DESTINATION/server.jar"
    cp "$TEMP_DIR/server.jar" "$DESTINATION/server.jar"
    exit 0
fi
    echo "*** INVALID FILE, EXITING ***"
    exit -1
done