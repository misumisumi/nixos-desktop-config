#
#  Main system configuration. More information available in configuration.nix(5) man page.
#
#  flake.nix
#   ├─ ./machines
#   │   └─ configuration.nix *
#   └─ ./modules
#       └─ ./editors
#           └─ ./neovim
#               └─ default.nix
#
{
  imports = [
    ./common/boot.nix
    ./common/network.nix
    ./common/default-user.nix
    ./common/nix-conf.nix
    ./common/services.nix
    ./common/system-env.nix
    ./common/ssh.nix
  ];
}
