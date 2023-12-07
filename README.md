[English](./README.md)|[日本語](./README-ja.md)

# misumisumi' NixOS & nix-darwin System Configuration & Home-Manager Configuration Flake

Welcome to the nix environment!  
This is [misumisumi](https://github.com/misumisumi)'s machine setup.

You can try NixOS using some of my setup.  
Currently, only the NixOS environment is supported.  
In the future, other distributions (user home config) and macOS will be supported.

## Description

- This repository is maintained by [Nix Flakes](https://nixos.wiki/wiki/Flakes).
- You can try out the environment created for recovery (gnome or CLI only).
- The settings of packages installed on the system are managed in [apps](./apps).
- Configuration of packages installed by users is managed in a separate repository: [home-manager-config]().
- Settings for each machine are located in [machines](./machines).

```
machines
├── init      # common settings
├── mother    # Main desktop
├── recovery  # For recovery
├── stacia    # Work desktop
└── zephyrus  # Laptop
```

## Installation Guide

### NixOS

- Boot via UEFI/systemd-boot, use disk encryption via LVM on LUKS
- Three environments can be used
  - gnome
  - tty-only

1. download Install media from [official](https://nixos.org/download.html)
2. boot ISO and check network connection
   - run `ip -c a and ping 8.8.8.8`
   - wireless settings use `nmcli` or `wpa_supplicant`
3. make partition and add partition label

   - use GPT partition label
   - Please see [archwiki](https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS)を参照 how to make LVM on LUKS

   |      For       |       Partition Type        | Partition label |     Suggested size      |
   | :------------: | :-------------------------: | :-------------: | :---------------------: |
   |     /boot      | EFI system partition (ef00) |       \-        |          128MB          |
   | LUKS partition |      Linux LVM (8E00)       | GENERALLUKSROOT | Remainder of the device |

   - partition of LVM on LUKS

     - You can make vfat label at `dosfslabel /dev/XXX <label>`
     - You can make ext4 label at`e2label /dev/XXX <label>`

     |  For  |    file system     |    label     |     Suggested size      |
     | :---: | :----------------: | :----------: | :---------------------: |
     | /boot |        vfat        |   ge-boot    |          128MB          |
     | /root |        ext4        | general-root |           4GB           |
     | /home |        ext4        | general-home | Remainder of the device |
     | /var  |        ext4        | general-var  |     more tharn 32GB     |
     | /nix  |        ext4        | general-nix  |     more tharn 64GB     |
     | swap  | use swap partition |      \-      |           4GB           |

4. disk mount

```
mount /dev/<for-root> /mnt
mkdir -p /mnt/{boot,home,var,nix}
mount /dev/<for-home> /mnt/home
mount /dev/<for-nix> /mnt/nix
mount /dev/<for-var> /mnt/var
mount /dev/<for-boot> /mnt/boot
```

5. Install.

```
cd machines/general
nix flake update
sudo nixos-install --flake . #{gnome|tty-only}
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

- Tilling WM Key Map

## ToDO

- [ ] support macOS
