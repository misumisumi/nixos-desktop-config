# misumisumi' NixOS & nix-darwin System Configuration & Home-Manager Configuration Flake

nix の世界へようこそ!!  
これは[misumisumi](https://github.com/misumisumi)のNixOSおよびhome-managerの設定です。

リカバリー用の設定使って NixOS を試すことができます。(Bootable Disk or LiveCD)

## 説明

- このリポジトリは[Nix Flakes](https://nixos.wiki/wiki/Flakes)によって管理されています。
- リカバリー用のgnomeまたはCLI環境を試用することができます。
- 各マシンの設定は[machines](./machines)にあります。
- ユーザー環境でのみ`nix`を使いたい場合は`home-manager`を試すことができます。

- system-wide

```
nixos-desktop-config
├── apps           # settings for installing apps
│   ├── system     # system wide
│   └── user       # user wide
│       ├── core   # common installing apps
│       ├── full   # include GUI
│       ├── medium # include latex
│       └── small  # include neovim and zsh
├── machines       # settings for each machine
├── modules        # nixosModules and homeManagerModules
├── patches        # patch of package
├── settings       # common machine settings
│   ├── system     # system wide
│   └── user       # user wide
├── sops           # secrets
└── users          # settings for each user
```

- only user-wide (home-manager)

```
# core config (Please see apps/user/core)
home-manager switch --flake ".#core"

# small config (Please see apps/user/small, Include `core`)
home-manager switch --flake ".#small"

# full config (Please see apps/user/full, Include `core` and `small`)
home-manager switch --flake ".#full"
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
