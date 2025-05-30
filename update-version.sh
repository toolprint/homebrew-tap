#!/bin/sh

# Configuration
PACKAGE_NAME="@onegrep/cli"
FORMULA_DIR="Formula"
TEMP_DIR="/tmp"

# Get latest version from npm
LATEST_VERSION=$(curl -s "https://registry.npmjs.org/$PACKAGE_NAME/latest" | jq -r '.version')

# Download the tarball
TARBALL_URL="https://registry.npmjs.org/$PACKAGE_NAME/-/cli-$LATEST_VERSION.tgz"
TARBALL_PATH="$TEMP_DIR/cli-$LATEST_VERSION.tgz"
curl -s "$TARBALL_URL" -o "$TARBALL_PATH"

# Calculate SHA256
NEW_SHA=$(shasum -a 256 "$TARBALL_PATH" | cut -d' ' -f1)

# Update all CLI formula files
for formula_file in "$FORMULA_DIR"/*-cli.rb; do
    echo "Updating $formula_file..."
    sed -i '' "s/VERSION = \"[0-9.]*\"/VERSION = \"$LATEST_VERSION\"/" "$formula_file"
    sed -i '' "s/SHA = \"[a-f0-9]*\"/SHA = \"$NEW_SHA\"/" "$formula_file"
    echo "Updated $formula_file to version $LATEST_VERSION"
done

# Cleanup
rm "$TARBALL_PATH"

echo "New SHA256: $NEW_SHA"
