{
  inputs,
  config,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [
    (final: prev: {
      _singularity = prev.singularity.overrideAttrs (old: {
        postFixup =
          old.postFixup
          + ''
            ${prev.lib.optionalString true ''
              substituteInPlace "$out/etc/singularity/singularity.conf" \
                --replace "# nvidia-container-cli path =" "nvidia-container-cli path = ${prev.nvidia-docker}/bin/nvidia-container-cli"
            ''}
          '';
      });
      singularity = config.programs.singularity.packageOverriden;
    })
  ];
  programs.singularity.enable = true;
  programs.singularity.package = pkgs._singularity;
  virtualisation = {
    lxc.enable = true;
    lxd = {
      enable = true;
      recommendedSysctlSettings = true;
      package = inputs.lxd-nixos.packages.x86_64-linux.lxd;
    };
    vfio = {
      enable = true;
      IOMMUType = "amd";
      blacklistNvidia = false;
      disableEFIfb = false;
      ignoreMSRs = true;
      applyACSpatch = false;
    };
    hugepages = {
      enable = false;
      defaultPageSize = "1G";
      pageSize = "1G";
      numPages = 16;
    };
    scream.enable = true;
  };
}