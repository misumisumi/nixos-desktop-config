# misumisumi' NixOS & nix-darwin System Configuration & Home-Manager Configuration Flake

nix の環境へようこそ!!  
これは[misumisumi](https://github.com/misumisumi)のマシン設定です。

私の設定の一部を利用して NixOS を試すことができます。  
現在、NixOS 環境のみサポートしています。  
将来的にmacOS をサポートする予定です。

## 説明

- このリポジトリは[Nix Flakes](https://nixos.wiki/wiki/Flakes)によって管理されています。
- リカバリー用に作成した環境(gnome or CLI only)を試用することができます。
- システムにインストールされるパッケージの設定は[apps](./apps)で管理されています。
- ユーザーにインストールされるパッケージの設定は別リポジトリ: [home-manager-config]()で管理されています。
- 各マシンの設定は[machines](./machines)にあります。

```
machines
├── init      # 共通設定
├── mother    # メインPC
├── recovery  # リカバリー用
├── stacia    # 研究室PC
└── zephyrus  # ラップトップ
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
|   Terminal   | wezterm && kitty  | wezterm && kitty  |
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
