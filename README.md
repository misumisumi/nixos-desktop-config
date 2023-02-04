# Sumi-Sumi' NixOS & nix-darwin System Configuration & Home-Manager Configuration Flake

This is configurations for Sumi-Sumi's machines.

You can try nix environment using my configurations.  
Supported platform is NixOS, other linux distributions (e.g. ubuntu, archlinux...) and macOS.

Let's try NixOS!!

## Common Installation Guide

- See [NixOS Installation Guide](#NixOS-Installation-Guide) if you use nix as linux distribution.
- See [Non NixOS Installation Guide](#Non-NixOS-Installation-Guide) if you use nix as package and .dotfiles manager on other linux distribution.
- See [Nix-Darwin Installation Guide](#Nix-Darwin-Installation-Guide) if you use nix on macOS.
- Apps settings in `./apps`
  - `./apps/common` is CUI apps settings.
  - `./apps/desktop` is GUI apps settings.
- Machine setting in `./machines/general/{minimal, desktop}`
  - e.g. Change `imports = [ ../common/pulseaudio.nix ]` to `imports = [ ../common/pipewire.nix ]`
    in `./machines/general/default.nix` if you want to use `pipewire`

## NixOS Installation Guide

This flakes currently has 2 Disktop Environments and 1 CLI Environments.

1. gnome
2. QTile (Can not use in VM)
3. minimal (CLI env)

All environments are configured with UEFI/systemd-boot.  
You can boot from external disk (e.g USB, other SSD/HDD...) or launch in VM.  
Details of the system configuration can be found in the [Appendix](#Appendix)  
Now, I assume using [LVM on LUKS](https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS)

1. Get install Mmdia from [Official Site](https://nixos.org/download.html) and Launch live environments
2. Check network connection
   - Check `ip -c a`
   - You can connect network using `nmtui`(GUI ISO) or `wpa_suppliant`(CUI ISO) if you use wifi.
3. Partition the disks and Format the partitions.

   - **You must add GPT partion labels.**
   - How to LVM on LUKS, see [LVM on LUKS](https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS).
   - Only LVM, see [LVM](https://wiki.archlinux.org/title/LVM).
   - You can edit `machines/general/{minimal,desktop}/hardware-configuration.nix` if you use other label or UUID.
     - You can generate `hardware-configuration.nix` automatically in next step.

   |      For       |       Partition Type        | Partition label |     Suggested size      |
   | :------------: | :-------------------------: | :-------------: | :---------------------: |
   |     /boot      | EFI system partition (ef00) |       \-        |          128MB          |
   | LUKS partition |      Linux LVM (8E00)       | GENERALLUKSROOT | Remainder of the device |

   - disk label and size
     - vfat label can be set by `dosfslabel /dev/XXX <label>`
     - ext4 label can be set by `e2label /dev/XXX <label>`

   |  For  |    file system     |    label     |     Suggested size      |
   | :---: | :----------------: | :----------: | :---------------------: |
   | /boot |        vfat        |   ge-boot    |          128MB          |
   | /root |        ext4        | general-root |           4GB           |
   | /home |        ext4        | general-home | Remainder of the device |
   | /var  |        ext4        | general-var  |     more tharn 32GB     |
   | /nix  |        ext4        | general-nix  |     more tharn 64GB     |
   | swap  | use swap partition |      \-      |           4GB           |

4. Mount the file systems.

```
mount /dev/<for-root> /mnt
mkdir -p /mnt/{boot,home,var,nix}
mount /dev/<for-home> /mnt/home
mount /dev/<for-nix> /mnt/nix
mount /dev/<for-var> /mnt/var
mount /dev/<for-boot> /mnt/boot
```

5. Install
   Now, available flake url is

   - `gnome`
   - `qtile`
   - `minimal`

     You can check `nix flake show` in `./machines/general`. (flake.nix of root is not available because this is include my private repository.)

```
git clone https://github.com/Sumi-Sumi/nixos-config.git /mnt/etc/nixos/config

Edit git account in apps/common/git/git.nix
------
(optional: You want to generate UUID and hardware conf automatically.)
nixos-generate-conifg --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/config/machines/general/{minimal,desktop}
------

cd machines/general
nix flake update
nixos-install --flake .#<flake-url>
```

6. Restart!
   - Initial login password is `general`.
   - You must select `GNOME on Wayland` when you use `gnome` and first start the program.
   - You can set "isLarge" and "addCLITools" instead "isMidium" in `machines/general/desktop/home.nix`, if you want to office, sns and etc. Please see apps/desktop/pkgs/default.nix

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

- [ ] add description of this repository
- [ ] support other linux distributions (non NixOS)
- [ ] support macOS
