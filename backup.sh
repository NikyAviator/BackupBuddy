#!/bin/bash

# Source and target directories
USB_PATH="/path/to/usb"
BACKUP_DIR="$HOME/Backup"

# Ensure backup directory exists
mkdir -p "$BACKUP_DIR"

# Sync folders using rsync
echo "Starting backup from $USB_PATH to $BACKUP_DIR..."
rsync -av --progress "$USB_PATH/" "$BACKUP_DIR/"

echo "Backup complete!"
