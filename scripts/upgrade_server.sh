#!/bin/bash

USER='minecraft'
BASEDIR="${1:-/opt/minecraft}"

VERSION_LOCAL=$(unzip -p $BASEDIR/server.jar META-INF/versions.list | awk '{ print $2 }')
echo "Current version: $VERSION_LOCAL"

MANIFEST=$(curl -s "https://piston-meta.mojang.com/mc/game/version_manifest.json")
LATEST=$(echo "$MANIFEST" | jq -r '.["latest"]["release"]')
if [[ "$LATEST" == "$VERSION_LOCAL" ]]; then
    echo "Already at latest version $LATEST"
    exit 1
fi

echo "Getting metadata for $LATEST"
LATEST_URL=$(echo "$MANIFEST" | jq -r '.["versions"] | map(select(.["id"] == "'"$LATEST"'"))[0] | .["url"]')
METADATA=$(curl -s "$LATEST_URL")
DOWNLOAD_HASH=$(echo $METADATA | jq -r '.["downloads"]["server"]["sha1"]')
DOWNLOAD_URL=$(echo $METADATA | jq -r '.["downloads"]["server"]["url"]')
echo "Downloading $DOWNLOAD_URL"

curl -o "$BASEDIR/server.tmp" "$DOWNLOAD_URL"
CALCULATED_HASH=$(sha1sum "$BASEDIR/server.tmp")
echo "Verifying $CALCULATED_HASH"

if [[ "$CALCULATED_HASH" = "$DOWNLOAD_HASH  $BASEDIR/server.tmp" ]]; then
    echo "Updating $BASEDIR/server.jar"
    mv "$BASEDIR/server.tmp" "$BASEDIR/server.jar"
    echo 'eula=true' > "$BASEDIR/eula.txt"
    sudo chown -R "$USER" "$BASEDIR"
    exit 0
else
    echo "*** INVALID FILE, EXITING ***"
    exit -1
fi