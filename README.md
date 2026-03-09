# USB Mount & Yazi Launcher 🐧📦

A lightweight Bash script to mount/unmount USB partitions via `udisksctl`, open them in
[`yazi`](https://github.com/sxyazi/yazi)

---

## 🔧 Features

- Lists only removable `/dev/sdX` partitions (ignores NVMe/system drives)
- Interactive selection menu with manual quit option
- Warns if a partition is already mounted
- Cleanly extracts the mount path using Bash
- Automatically unmounts after closing `yazi`
- Zero dependencies beyond `udisksctl`, `lsblk`, and `yazi`

---

## 🚀 Installation & Usage

1. Clone and run install script:

```bash
git clone https://github.com/Sora-3e8/yazi-mount-universal
# The make script install the script into target directory
sudo make install

```

2. Usage in terminal and yazi:

**For USB type this**

```bash
  $ :usb
```
> Note:
> The original phone mounting feature was removed as it was not ported yet into the new format.
> This will be hopefully re-added later once proper solution is in place.

3. Browse the mounted device with yazi – once you quit yazi.

## 📋 Requirements

- bash
- yazi
- udisksctl
- lsblk
- gum
- noto-fonts-emoji (or something similar for icons)

Make sure your user has permission to use udisksctl (usually no sudo required for mounting USB devices).

## 🛡️ Safety

- Only shows /dev/sdX devices (ignores NVMe system drives)
- Does not force mount anything
- Checks if device is already mounted before attempting to mount/unmount
- Lets the user abort at any time with q

## 📃 License

### MIT – feel free to fork, improve, and share!

## ❌ Uninstallation

1. Remove the plugin folder:

   ```bash
   sudo make uninstall
   # Or if you want to manually remove it
   sudo rm /usr/local/bin/:usb 

   ```
2. Optional: If you no longer need the additional software (udisksctl, lsblk, noto-fonts-emoji), you can uninstall them using your package manager.
