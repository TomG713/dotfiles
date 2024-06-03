#!/usr/bin/env bash

# Define the repo URL and the directory name
REPO_URL="https://github.com/ryanoasis/nerd-fonts.git"
DIR_NAME="nerd-fonts"
FONT_DIR="$HOME/.local/share/fonts/NerdFonts"

# Check if the NerdFonts directory already exists
if [ -d "$FONT_DIR" ]; then
  echo "NerdFonts directory already exists at $FONT_DIR. Skipping installation."
  exit 0
fi

# Clone the repo
git clone --depth 1 $REPO_URL

# Check if cloning was successful
if [ $? -eq 0 ]; then
  echo "Cloned the repo successfully."
else
  echo "Failed to clone the repo."
  exit 1
fi

# Change to the cloned repo directory
cd $DIR_NAME

# Run the install script
./install.sh

# Check if the install script ran successfully
if [ $? -eq 0 ]; then
  echo "Installation completed successfully."
else
  echo "Installation failed."
  exit 1
fi

# Go back to the parent directory
cd ..

# Delete the cloned repo
rm -rf $DIR_NAME

# Check if the deletion was successful
if [ $? -eq 0 ]; then
  echo "Deleted the repo successfully."
else
  echo "Failed to delete the repo."
  exit 1
fi

