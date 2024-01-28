# misumisumi' NixOS & nix-darwin System Configuration & Home-Manager Configuration Flake

nix の世界へようこそ!!  
これは[misumisumi](https://github.com/misumisumi)のマシン設定です。

リカバリー用の設定使って NixOS を試すことができます。(Bootable Disk or LiveCD)

## 説明

- このリポジトリは[Nix Flakes](https://nixos.wiki/wiki/Flakes)によって管理されています。
- リカバリー用のgnomeまたはCLI環境を試用することができます。
- このリポジトリではシステム設定のみ管理されています。
- ユーザーにインストールされるパッケージの設定は別リポジトリ: [home-manager-config](https://github.com/misumisumi/home-manager-config)で管理されています。
- 各マシンの設定は[machines](./machines)にあります。

```
nixos-desktop-config
├── apps           # アプリ設定
├── hm             # home-manager config
├── machines       # 各マシンの設定
│   ├── init       # マシン共通設定
│   ├── liveimg    # live環境
│   ├── mother     # メインPC
│   ├── soleus     # デスクトップ
│   ├── stacia     # デスクトップ
│   └── zephyrus   # ラップトップ
├── modules        # nixosModules
├── patches        # nixpkgsのパッチ
└── system         # システム共通設定
```

## インストールガイド

### NixOS

1. `nix`環境の構築

- Container from [DockerHub (nixos/nix)](https://hub.docker.com/r/nixos/nix/tags)
- Install nix package manager from [official guide](https://nixos.org/download)
- Launch VM using [official iso](https://nixos.org/download)

2. ネットワーク接続の確認

   - run `ip -c a and ping 8.8.8.8`
   - wireless settings use `nmcli` or `wpa_supplicant`

3. インストール

   - Bootable External Disk

   ```sh
   # Create key file for luks
   echo <password> > /tmp/luks.key
   # In root env

   # Format disk and mount to `/mnt`
   # "liveimg-cui" for CUI env, "liveimg-gui" for GUI env
   nix run nixpkgs#disko -- -m disko --flake ("github:misumisumi/nixos-desktop-config#liveimg-cui" or "github:misumisumi/nixos-desktop-config#liveimg-gui")

   # Install NixOS to `/mnt`
   nixos-install --no-root-passwd --flake ("github:misumisumi/nixos-desktop-config#liveimg-cui" or "github:misumisumi/nixos-desktop-config#liveimg-gui")
   ```

   - Create LiveCD

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
|   Terminal   |      Wezterm      |      Wezterm      |
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
