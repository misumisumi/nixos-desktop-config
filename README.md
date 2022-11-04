# Sumi-Sumi' NixOS & nix-darwin System Configuration & Home-Manager Configuration Flake

This is configurations for Sumi-Sumi's machines.

You can try nix environment using my configurations.    
Supported platform is NixOS, other linux distributions (e.g. ubuntu, archlinux...) and macOS.

Let's try NixOS!!

## Note
This repository is now working.

## Common Installation Guide
- See [NixOS Installation Guide](#NixOS-Installation-Guide) if you use nix as linux distribution.
- See [Non NixOS Installation Guide](#Non-NixOS-Installation-Guide) if you use nix as package and .dotfiles manager on other linux distribution.
- See [Nix-Darwin Installation Guide](#Nix-Darwin-Installation-Guide) if you use nix on macOS.
- Apps settings in `./apps`
    - `./apps/common` is CUI apps settings.
    - `./apps/desktop` is GUI apps settings.
- Machine setting in './machines/general/'
    - e.g. Change `imports = [ ../common/pulseaudio.nix ]` to `imports = [ ../common/pipewire.nix ]`
      in `./machines/general/default.nix` if you want to use `pipewire` 

## NixOS Installation Guide
This flakes currently has 2Disktop Environments.
  1. KDE Plasma5
  2. QTile (Can not use in VM)

All environments are configured with UEFI/systemd-boot.    
You can boot from external disk (e.g USB, other SSD/HDD...) or launch in VM.     
Details of the system configuration can be found in the [Appendix](#Appendix)    
Now, I assume using [LVM on LUKS](https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS)    
You run `preprocess.sh --lvm-only` in `preprocess` if you use only LVM.

1. Get install Mmdia from [Official Site](https://nixos.org/download.html) and Launch live environments
2. Check network connection
    - Check `ip -c a`
    - You can connect network using `nmtui`(GUI ISO) or `wpa_suppliant`(CUI ISO) if you use wifi.
3. Partition the disks and Format the partitions.
    - **You must add GPT partion labels.**
    - How to LVM on LUKS, see [LVM on LUKS](https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS).
    - Only LVM, see [LVM](https://wiki.archlinux.org/title/LVM).
    - You can edit `machines/general/hardware-configuration.nix` if you use other label or UUID.
      - You can generate `hardware-configuration.nix` automatically in next step.

    | For            | Partition Type              | Partition label | Suggested size          |
    | :-:            | :-:                         | :-:             | :-:                     |
    | /boot          | EFI system partition (ef00) | \-              | 512MB                   |
    | LUKS partition | Linux LVM (8E00)            | GENERALLUKSROOT | Remainder of the device |

    - disk label

    | For   | file system | label        | how to                          |
    | :-:   | :-:         | :-:          | :-:                             |
    | /boot | vfat        | ge-boot      | `dosfslabel /dev/XXX ge-boot`    |
    | /root | ext4        | general-root | `e2label /dev/XXX general-root` |
    | /home | ext4        | general-home | `e2label /dev/XXX general-home`
4. Mount the file systems.
  ```
  sudo mount /dev/<for-root> /mnt
  sudo mkdir -p /mnt/{boot,home}
  sudo mount /dev/<for-home> /mnt/home
  sudo mount /dev/<for-boot> /mnt/boot
  ```
5. Install
  Now, available flake url is
    - `plasma5`
    - `qtile`
  You can check `nix flake show` in `./machines`. (flake.nix of root is not available because this is include my private repository.)

  ```
  sudo git clone https://github.com/Sumi-Sumi/nixos-config.git /mnt/etc/nixos/config

  ------
  (optional: You want to generate UUID and hardware conf automatically.)
  sudo dd if=/dev/zero of=/mnt/.swapfile bs=1024 count=$((1024*4))  # swap size is 4GB
  sudo chmod 600 /mnt/.swapfile
  sudo mkswap /mnt/.swapfile
  sudo swapon /mnt/.swapfile
  sudo nixos-generate-conifg --root /mnt
  sudo cp /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/config/machines/general/
  ------

  cd /mnt/etc/nixos/config/preprocess
  (LVM only): sudo ./preprocess.sh --lvm-only
  cd ../machines
  sudo nix flake update
  sudo nixos-install --flake .#<flake-url>
  ```

6. Restart!
    - Initial login password is `general`.
    - Please change git account info. (edit `apps/common/git/git.nix`)

## Appendix
### System Compornents

- Common Compornents

|              | Linux             | macOS             |
| :-:          | :-:               | :-:               |
| Shell        | Zsh               | Zsh               |
| Terminal     | Kitty & Alacritty | Kitty & Alacritty |
| Editor       | Neovim & VSCode   | Neovim & VSCode   |
| Browser      | Vivaldi & Firefox | Vivaldi & Firefox |
| Input Method | Fcitx5+mozc       | \-                |
| Launcher     | Rofi              | \-                |
| GTK Theme    | Adapta-Nokto-Eta  | \-                |
| Icon Theme   | Papirus-Dark      | \-                |
| System Font  | Source Han Sans   | \-                |

| DE      | Window System   |
| :-:     | :-:             |
| Plasma5 | Wayland or Xorg |
| QTile   | Xorg            |
| Yabai   | macOS           |

- Tilling WM Key Map

## ToDO
- [ ] add description of this repository
- [ ] support other linux distributions (non NixOS)
- [ ] support macOS
