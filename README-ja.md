# misumisumi' NixOS & nix-darwin System Configuration & Home-Manager Configuration Flake

nix の環境へようこそ!!  
これは[misumisumi](https://github.com/misumisumi)のマシン設定です。

私の設定の一部を利用して NixOS を試すことができます。  
現在、NixOS 環境のみサポートしています。  
将来的に他のディストリブーション(user home config)、macOS をサポートする予定です。

## 説明

- このリポジトリは[Nix Flakes](https://nixos.wiki/wiki/Flakes)によって管理されています。
- リカバリー用に作成した環境(gnome or qtile or CLI only)を試用することができます。
  - root の[flake.nix](./flake.nix)は private repository を含むため使用できません。  
    詳しくはインストールガイドを見てください。
- 各アプリの設定は[apps](./apps)にあります。
- 各マシンの設定は[machines](./machines)にあります。
  - mother, stacia, zephyrus は private-repository を含むため使用できません。

```
machines
├── common # 各マシン共通の設定
├── general # 汎用環境(リカバリー用)
│   ├── desktop # gnome or qtile
│   └── minimal # CLI only
├── mother # My Desktop
├── stacia # My GPU server with desktop
└── zephyrus # My Laptop
```

## インストールガイド

### NixOS

- UEFI/systemd-boot によるブート、LVM on LUKS によるディスク暗号化を使用
- 3 つの環境を使うことができます。
  - gnome
  - qtile
  - minimal (CLI only)

1. [公式](https://nixos.org/download.html)から Install media のダウンロード
2. ISO の起動とネットワーク接続の確認
   - run `ip -c a and ping 8.8.8.8`
   - WiFi の設定は`nmcli`または`wpa_supplicant`
3. パーティションの作成とラベルの付与

   - GPT パーティションラベルを使用
   - LVM on LUKS の設定は[archwiki](https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS)を参照

   |      For       |       Partition Type        | Partition label |     Suggested size      |
   | :------------: | :-------------------------: | :-------------: | :---------------------: |
   |     /boot      | EFI system partition (ef00) |       \-        |          128MB          |
   | LUKS partition |      Linux LVM (8E00)       | GENERALLUKSROOT | Remainder of the device |

   - LVM on LUKS パーティション

     - vfat label は`dosfslabel /dev/XXX <label>`で作成
     - ext4 label は`e2label /dev/XXX <label>` で作成

     |  For  |    file system     |    label     |     Suggested size      |
     | :---: | :----------------: | :----------: | :---------------------: |
     | /boot |        vfat        |   ge-boot    |          128MB          |
     | /root |        ext4        | general-root |           4GB           |
     | /home |        ext4        | general-home | Remainder of the device |
     | /var  |        ext4        | general-var  |     more tharn 32GB     |
     | /nix  |        ext4        | general-nix  |     more tharn 64GB     |
     | swap  | use swap partition |      \-      |           4GB           |

4. ディスクマウント

```
mount /dev/<for-root> /mnt
mkdir -p /mnt/{boot,home,var,nix}
mount /dev/<for-home> /mnt/home
mount /dev/<for-nix> /mnt/nix
mount /dev/<for-var> /mnt/var
mount /dev/<for-boot> /mnt/boot
```

5. インストール
   ```
   cd machines/general
   nix flake update
   sudo nixos-install --flake .#{gnome|qtile|minimal}
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

- [ ] add description of this repository
- [ ] support other linux distributions (non NixOS)
- [ ] support macOS

```

```