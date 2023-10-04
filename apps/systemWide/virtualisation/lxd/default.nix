{ inputs, pkgs, ... }: {

  system.activationScripts.virtiofs.text = ''
    mkdir -p /usr/lib/qemu
    ln -sf ${pkgs.virtiofsd}/bin/virtiofsd /usr/lib/qemu/virtiofsd
  '';
  virtualisation = {
    lxc.enable = true;
    lxd = {
      enable = true;
      recommendedSysctlSettings = true;
      package = inputs.lxd-nixos.packages.x86_64-linux.lxd;
    };
  };
}
