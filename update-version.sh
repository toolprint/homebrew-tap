#!/bin/sh

# Configuration
PACKAGE_NAME="@onegrep/cli"
FORMULA_PATH="Formula/onegrep-cli.rb"
TEMP_DIR="/tmp"

# Get latest version from npm
LATEST_VERSION=$(curl -s "https://registry.npmjs.org/$PACKAGE_NAME/latest" | jq -r '.version')

# Download the tarball
TARBALL_URL="https://registry.npmjs.org/$PACKAGE_NAME/-/cli-$LATEST_VERSION.tgz"
TARBALL_PATH="$TEMP_DIR/cli-$LATEST_VERSION.tgz"
curl -s "$TARBALL_URL" -o "$TARBALL_PATH"

# Calculate SHA256
NEW_SHA=$(shasum -a 256 "$TARBALL_PATH" | cut -d' ' -f1)

# Update the formula file
sed -i '' "s/VERSION = \"[0-9.]*\"/VERSION = \"$LATEST_VERSION\"/" "$FORMULA_PATH"
sed -i '' "s/SHA = \"[a-f0-9]*\"/SHA = \"$NEW_SHA\"/" "$FORMULA_PATH"

# Cleanup
rm "$TARBALL_PATH"

echo "Updated $FORMULA_PATH to version $LATEST_VERSION"
echo "New SHA256: $NEW_SHA"
