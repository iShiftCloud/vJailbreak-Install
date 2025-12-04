#!/bin/bash

# Define target directories and file name
# Note: Since the repository is public, credentials are NOT needed.
REPO_URL="https://github.com/iShiftCloud/vjb-automation.git"
CLONE_DIR="/tmp/vJailbreak-Install_temp"
TARGET_DIR="/home/ubuntu"
VMWARE_TAR_PATTERN="VMware-vix-disklib-*.tar.gz"

echo "*******Downloading and setting up VMware-vix-disklib*****"

# --- A. Remove Credential Prompts (No longer needed) ---
# We no longer need: read -p "Enter your GitHub Username: " GITHUB_USER
# We no longer need: read -s -p "Enter your GitHub Password/Personal Access Token: " GITHUB_PASS
# We no longer need: echo # Newline after password prompt

# --- B. Clone the repository anonymously ---

if [ -d "$CLONE_DIR" ]; then
    echo "Temporary directory $CLONE_DIR already exists. Deleting it..."
    rm -rf "$CLONE_DIR"
fi

echo "Cloning repository into $CLONE_DIR..."
# Use the public URL directly
git clone "$REPO_URL" "$CLONE_DIR"

if [ $? -ne 0 ]; then
    echo "FATAL: Git clone failed. Check repository URL."
    exit 1
fi

# --- C. Locate, Move, and Extract the file ---

# Find the specific tarball file within the cloned directory
library_file=$(find "$CLONE_DIR" -name "$VMWARE_TAR_PATTERN" -print -quit)

if [ -z "$library_file" ]; then
    echo "FATAL: Could not find the VMware library tarball ($VMWARE_TAR_PATTERN) in the repository."
    rm -rf "$CLONE_DIR"
    exit 1
fi

echo "Found library file: $(basename "$library_file")"

# 1. Move the tar file to the target directory
echo "Moving file to $TARGET_DIR/"
mv "$library_file" "$TARGET_DIR/"

# 2. Extract the file within the target directory
# Change to the target directory for easier extraction
cd "$TARGET_DIR" || { echo "FATAL: Failed to change directory to $TARGET_DIR"; exit 1; }

echo "Extracting the file..."
extracted_file=$(basename "$library_file")
tar -xvzf "$extracted_file"

# 3. Clean up the temporary clone directory
echo "Cleaning up temporary clone directory..."
rm -rf "$CLONE_DIR"

echo "*******VMware-vix-disklib setup complete!*****"
