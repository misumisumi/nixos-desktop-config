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
      devices = [];
      # devices = [ "10de:2204" "10de:1aef" ];
      deviceDomains = ["0000:09:00.0" "0000:09:00.1"];
      blacklistNvidia = false;
      disableEFIfb = false;
      ignoreMSRs = true;
      applyACSpatch = false;
      hook = {
        enable = true;
        preHook = {
          win11 = ''
            #! /usr/bin/env bash
            echo "0000:09:00.0" >/sys/bus/pci/devices/0000:09:00.0/driver/unbind
            echo "0000:09:00.1" >/sys/bus/pci/devices/0000:09:00.1/driver/unbind
            nowDriver="$(lspci -s 0000:09:00.0 | grep "Kernel driver in use" | awk -F' ' '{print $5}')"
            if [ "''${nowDriver}" != "nvidia" ]; then
              echo "nvidia" >/sys/bus/pci/devices/0000:09:00.0/driver/driver_override
              echo "0000:09:00.0" >/sys/bus/pci/devices/0000:09:00.0/driver/bind
              echo "0000:09:00.1" >/sys/bus/pci/devices/0000:09:00.1/driver/bind
              sleep 1
              echo "0000:09:00.0" >/sys/bus/pci/devices/0000:09:00.0/driver/unbind
              echo "0000:09:00.1" >/sys/bus/pci/devices/0000:09:00.1/driver/unbind
            fi

            virsh nodedev-detach pci_0000_09_00_0
            virsh nodedev-detach pci_0000_09_00_1
          '';
        };
        postHook = {
          win11 = ''
            #! /usr/bin/env bash
            echo "0000:09:00.0" >/sys/bus/pci/devices/0000:09:00.0/driver/unbind
            echo "0000:09:00.1" >/sys/bus/pci/devices/0000:09:00.1/driver/unbind

            virsh nodedev-reattach pci_0000_09_00_0
            virsh nodedev-reattach pci_0000_09_00_1
          '';
        };
      };
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