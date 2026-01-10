#!/bin/bash

BASEDIR="${1:-/opt/minecraft}"

VERSION_LOCAL=$(unzip -p $BASEDIR/server.jar META-INF/versions.list | awk '{ print $2 }')
echo "Current version: $VERSION_LOCAL"

MANIFEST=$(curl -s "https://piston-meta.mojang.com/mc/game/version_manifest.json")
LATEST=$(echo "$MANIFEST" | jq -r '.["latest"]["release"]')
if [[ "$LATEST" == "$VERSION_LOCAL" ]]; then
    echo "Already at latest version $LATEST"
    exit 0
fi

echo "Getting metadata for $LATEST"
LATEST_URL=$(echo "$MANIFEST" | jq -r '.["versions"] | map(select(.["id"] == "'"$LATEST"'"))[0] | .["url"]')
METADATA=$(curl -s "$LATEST_URL")
DOWNLOAD_HASH=$(echo $METADATA | jq -r '.["downloads"]["server"]["sha1"]')
DOWNLOAD_URL=$(echo $METADATA | jq -r '.["downloads"]["server"]["url"]')
echo "Downloading $DOWNLOAD_URL"

DOWNLOAD_FILE=""$BASEDIR/server_$LATEST.jar""
curl -o "$DOWNLOAD_FILE" "$DOWNLOAD_URL"
CALCULATED_HASH=$(sha1sum "$DOWNLOAD_FILE")
echo "Verifying $CALCULATED_HASH"

if [[ "$CALCULATED_HASH" -ne "$DOWNLOAD_HASH  $DOWNLOAD_FILE" ]]; then
    echo "*** INVALID FILE, EXITING ***"
    rm "$DOWNLOAD_FILE"
    exit -1
fi

echo "Updating $BASEDIR/server.jar from $VERSION_LOCAL to $LATEST"
systemctl stop minecraft
mv "$DOWNLOAD_FILE" "$BASEDIR/server.jar"
systemctl start minecraft
