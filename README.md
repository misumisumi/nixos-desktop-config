# Sumi-Sumi' NixOS & nix-darwin System Configuration & Home-Manager Configuration Flake

This is configurations for Sumi-Sumi's machines.

You can try nix environment using my configurations.
Supported platform is NixOS, other linux distributions (e.g. ubuntu, archlinux...) and macOS.

Let's try NixOS!!

## Common Installation Guide
- You must edit some files befor you install.

1. Edit [flake.nix](./flake.nix) & Update [flake.lock](./flake.lock)
  - comment `private-conf` (in `inputs`)
  - commentout new `outputs` and comment old one

## ToDO
- [ ] add description of this repository
- [ ] support other linux distributions (non NixOS)
- [ ] support macOS
