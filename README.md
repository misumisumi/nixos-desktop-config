[English](./README.md)|[日本語](./README-ja.md)

# misumisumi' NixOS & nix-darwin System Configuration & Home-Manager Configuration Flake

Welcome to the nix World!  
This is [misumisumi](https://github.com/misumisumi)'s machine setup.

You can try NixOS using some of my setup.  
Currently, only the NixOS environment is supported.  
In the future, other distributions (user home config) and macOS will be supported.

## Description

- This repository is maintained by [Nix Flakes](https://nixos.wiki/wiki/Flakes).
- You can try out gnome or CLI environment for recovery.
- This repository only manages system settings.
- The configuration of packages installed by users is managed in a separate repository: [home-manager-config](https://github.com/misumisumi/home-manager-config).
- Settings for each machine are located in [machines](./machines).

```
nixos-desktop-config
├── apps           # app settings
├── hm             # home-manager config
├── machines       # each machine configs
│   ├── init       # common machine config
│   ├── liveimg    # liveimg
│   ├── mother     # My Main PC
│   ├── soleus     # Desktop
│   ├── stacia     # Desktop
│   └── zephyrus   # Laptop
├── modules        # nixosModules
├── patches        # patch for nixpkgs
└── system         # common system config
```

## Installation Guide

1. Create `nix` env

- Container from [DockerHub (nixos/nix)](https://hub.docker.com/r/nixos/nix/tags)
- Install nix package manager from [official guide](https://nixos.org/download)
- Launch VM using [official iso](https://nixos.org/download)

2. Check networking connection

   - run `ip -c a and ping 8.8.8.8`
   - wireless settings use `nmcli` or `wpa_supplicant`

3. Install

#### Bootable External Disk

```sh
# Create key file for luks
echo <password> > /tmp/luks.key
# In root env

# Format disk and mount to `/mnt`
# **Need edit `device` in ./machines/liveimg/filesystem.nix**
# "liveimg-cui" for CUI env, "liveimg-gui" for GUI env
nix run nixpkgs#disko -- -m disko --flake ("github:misumisumi/nixos-desktop-config#liveimg-cui" or "github:misumisumi/nixos-desktop-config#liveimg-gui")

# Install NixOS to `/mnt`
nixos-install --no-root-passwd --flake ("github:misumisumi/nixos-desktop-config#liveimg-cui" or "github:misumisumi/nixos-desktop-config#liveimg-gui")
```

#### Create LiveCD

```sh
# Create .iso file
nix run nixpkgs#nixos-generators -- --format iso -o result --flake github:misumisumi/nixos-desktop-config#liveimg-iso

# Write iso to device
dd if=result/iso/*.iso of=/dev/sdX status=progress
```

## Appendix

### System Compornents

- Common Compornents

|              |       Linux       |       macOS       |
| :----------: | :---------------: | :---------------: |
|    Shell     |        Zsh        |        Zsh        |
|   Terminal   | Kitty & Alacritty | Kitty & Alacritty |
|    Editor    |      Neovim       |      Neovim       |
|   Browser    | Vivaldi & Firefox | Vivaldi & Firefox |
| Input Method | Fcitx5+mozc & skk |        \-         |
|   Launcher   |       Rofi        |        \-         |
|  GTK Theme   | Adapta-Nokto-Eta  |        \-         |
|  Icon Theme  |   Papirus-Dark    |        \-         |
| System Font  |  Source Han Sans  |        \-         |

|  DE   |  Window System  |
| :---: | :-------------: |
| gnome | Wayland or Xorg |
| QTile |      Xorg       |
| Yabai |      macOS      |

## ToDO

- [ ] support macOS
