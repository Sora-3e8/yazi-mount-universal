#!/bin/bash

# List all removable block partitions (filtering out NVMe/system drives)
echo "📦 Available removable partitions:"
lsblk -o NAME,SIZE,TYPE,MOUNTPOINT | grep -E '^sd.*part'

# Collect only /dev/sdX-type partitions (no nvme, loop, etc.)

mapfile -t devices < <(lsblk -lnpo NAME,TYPE,LABEL,SIZE | awk '$1 ~ "/dev/sd" && $2 == "part" {if(NF==3){$4=$3; $3="[no label]";} print $1,$3,$4 }')

# Exit if no suitable devices are found
if [[ ${#devices[@]} -eq 0 ]]; then
  echo "❌ No suitable USB partitions found."
  exit 1
fi

echo
echo "🔍 Please choose a device to mount (or type 'q' to quit):"

# Use gum for selection menu
selected=$(gum choose "${devices[@]}"| awk '{print $1}')
if [[ -z "$selected" ]]; then
  echo "👋 Exited by user."
  exit 0
fi
dev="$selected"

# Check if the selected device is already mounted
MOUNTED_PATH=$(lsblk -npo MOUNTPOINT "$dev" | grep -v '^$')

if [[ -n "$MOUNTED_PATH" ]]; then
  echo "✅ Device $dev is already mounted at: $MOUNTED_PATH"
  if gum confirm "❓ Do you want to umount the device"; then
    echo "🔌 Unmounting $dev..."
    udisksctl unmount -b "$dev"
    exit 0
  fi
  MOUNTPOINT="$MOUNTED_PATH"
else
  # Mount the selected device
  MOUNT_OUTPUT=$(udisksctl mount -b "$dev" 2>&1)
  if [[ $? -ne 0 ]]; then
    echo "❌ Mount failed:"
    echo "$MOUNT_OUTPUT"
    exit 1
  fi

  # Extract the mount path from the output (pure Bash)
  MOUNTPOINT="${MOUNT_OUTPUT##* at }"
  MOUNTPOINT="${MOUNTPOINT%.}"
fi

# Confirm before launching Yazi
if gum confirm "Do you want to open $MOUNTPOINT in yazi?"; then
  yazi "$MOUNTPOINT"
fi
