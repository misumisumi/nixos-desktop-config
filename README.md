[English](./README.md)|[日本語](./README-ja.md)

# misumisumi' NixOS System & Home-Manager Configuration by Flake

Welcome to the nix World!  
This is [misumisumi](https://github.com/misumisumi)'s NixOS and home-manager configurations.

![thumbnail](./assets/thumbnail.png)

## Description

- This repository is maintained by [Nix Flakes](https://nixos.wiki/wiki/Flakes).
- You can try desktop or CLI environment.
  - DE: Qtile or GNOME
- Support standalone [home-manager](https://github.com/nix-community/home-manager)
- Support selecting color-scheme
- Providing my custom modules

```
nixos-desktop-config
├── apps           # settings for installing apps
│   ├── system     # system wide application configurations (NixOS options)
│   └── user       # user wide application configurations (home-manager options)
│       ├── core   # common installing apps
│       ├── full   # include GUI
│       ├── medium # include latex
│       └── small  # include neovim and useful apps
├── machines       # settings for each my machines
├── modules        # my custom nixosModules and homeManagerModules
├── patches        # patch of package
├── settings       # common system settings
│   ├── system     # system wide
│   └── user       # user wide
├── sops           # secrets
└── users          # settings for each users
```

## Module Usage

```nix
{
  inputs = {
    dotfiles.url = "github:misumisumi/nixos-desktop-config"
    # ...
  };
  # ...
  # import nixosModules by inputs.dotfiles.nixosModules.<module-name>
  # import homeManageModules by inputs.dotfiles.homeManagerModules.<module-name>
}
```

## Installation Guide

> [!WARNING] ⚠️  
> I maintain it with a focus on making it work in my own environment.  
> `liveimg-*` and standalone `home-manager` are not well tested.

1. Create `nix` env

- Container from [DockerHub (nixos/nix)](https://hub.docker.com/r/nixos/nix/tags)
- Install nix package manager from [official guide](https://nixos.org/download)
- Launch VM using [official iso](https://nixos.org/download)

2. Check networking connection

   - run `ip -c a and ping 8.8.8.8`
   - wireless settings use `nmcli` or `wpa_supplicant`

3. Install

- Read it as `--flake .#<flake-name>` if you clone the repository,

#### Bootable External Disk

```sh
# 1. Create key file for luks
echo <password> > /tmp/luks.key

# 2. Edit `device` in machines/liveimg/filesystem

# 3. Check flake name (liveimg-cui-* or liveimg-gui-*, *-iso is for ISO creation, not use here)

# 4. Format disk and mount to `/mnt`
# "liveimg-cui" for CUI env, "liveimg-gui" for GUI env
nix run nixpkgs#disko -- -m disko --flake "github:misumisumi/nixos-desktop-config#<flake-name>"

# Install NixOS to `/mnt`
nixos-install --no-root-passwd --flake "github:misumisumi/nixos-desktop-config#<flake-name>"
```

#### Create LiveCD

```sh
# 1. Check flake name (liveimg-iso-*)
# 2. Create .iso file (build takes a long time)
nix run nixpkgs#nixos-generators -- --format iso -o result --flake github:misumisumi/nixos-desktop-config#<flake-name>

# Write iso to device
dd if=result/iso/*.iso of=/dev/sdX status=progress
```

#### Standalone home-manager

1. Setup home-manager

- See [home-manager official manual](https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone)

2. Switch to config

```sh
  home-manager switch --flake github:misumisumi/nixos-desktop-config#<core or small or medium or full>
```

## Appendix

### System Compornents

- Common Compornents

|               |        Linux (GNOME)         |        Linux (Qtile)         |
| :-----------: | :--------------------------: | :--------------------------: |
| window system |       Wayland or Xorg        |             Xorg             |
|     Shell     |             Zsh              |             Zsh              |
|   Terminal    |           Wezterm            |           Wezterm            |
|    Editor     |            Neovim            |            Neovim            |
|    Browser    |      Vivaldi & Firefox       |      Vivaldi & Firefox       |
| Input Method  |      Fcitx5+mozc & skk       |         Fcitx5 & skk         |
|   Launcher    |             Rofi             |             Rofi             |
|     Theme     | catppuccin, nord, tokyonight | catppuccin, nord, tokyonight |
|  System Font  |        Noto Fonts CJK        |        Noto Fonts CJK        |

### Gallery

<h4 style="text-align: center">catppuccin-macchiato</h4>

![tumbnail catppuccin-macchiato](./assets/catppuccin-macchiato.png)

<h4 style="text-align: center">nord</h4>

![tumbnail nord](./assets/nord.png)

<h4 style="text-align: center">tokyonight-moon</h4>

![tumbnail tokyonight-moon](./assets/tokyonight-moon.png)
