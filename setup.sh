#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}🚀 Starting MU Plugin Setup...${NC}"

# Get plugin name from directory name if not provided
PLUGIN_NAME="${1:-$(basename $(pwd))}"
VENDOR_NAME="${2:-ModernMU}"
NAMESPACE="${VENDOR_NAME}\\Core"

# Convert plugin name to title case for class names
PLUGIN_TITLE=$(echo "$PLUGIN_NAME" | sed -r 's/(^|-)([a-z])/\U\2/g' | sed 's/-//g')

echo -e "${GREEN}✓ Setting up plugin: $PLUGIN_NAME${NC}"
echo -e "${GREEN}✓ Using namespace: $NAMESPACE${NC}"

# Update composer.json
echo -e "${YELLOW}Updating composer.json...${NC}"
sed -i "s/\"your-vendor\/wordpress-mu-plugin\"/\"$(echo "$VENDOR_NAME" | tr '[:upper:]' '[:lower:]')\/$(echo "$PLUGIN_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')/g" composer.json

# Update namespaces in PHP files
echo -e "${YELLOW}Updating namespaces in PHP files...${NC}"
find . -type f -name "*.php" -exec sed -i "s/YourVendor\\\\YourPluginName/$(echo $NAMESPACE | sed 's/\\/\\\\/g')/g" {} \;
find . -type f -name "composer.json" -exec sed -i "s/YourVendor\\\\/$(echo $VENDOR_NAME | sed 's/\\/\\\\/g')\\\/g" {} \;

# Update plugin header
echo -e "${YELLOW}Updating plugin header...${NC}"
sed -i "s/Plugin Name: Modern MU Plugin/Plugin Name: $PLUGIN_TITLE/g" mu-plugin.php
sed -i "s/Description: A modern WordPress must-use plugin with Composer and PSR-4 autoloading/Description: $PLUGIN_TITLE - A modern WordPress must-use plugin/g" mu-plugin.php

# Update class names
echo -e "${YELLOW}Updating class names...${NC}"
find . -type f -name "*.php" -exec sed -i "s/class Plugin/class ${PLUGIN_TITLE}_Plugin/g" {} \;
find . -type f -name "*.php" -exec sed -i "s/Plugin::get_instance()/${PLUGIN_TITLE}_Plugin::get_instance()/g" {} \;

# Install dependencies
echo -e "${YELLOW}Installing dependencies...${NC}"
composer install

echo -e "${GREEN}✓ Setup complete! Your plugin is ready to use.${NC}"
echo -e "${YELLOW}Don't forget to update the README.md with your plugin's specific information.${NC}"
