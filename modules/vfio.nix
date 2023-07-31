# From https://gist.github.com/CRTified/43b7ce84cd238673f7f24652c85980b3
{ lib
, pkgs
, config
, ...
}:
with lib;
with types; let
  cfg = config.virtualisation.vfio;
  # acscommit = "1ec4cb0753488353e111496a90bdfbe2a074827e";
  hookModules = submodule {
    options = {
      enable = mkEnableOption "Enable hook";
      preHook = mkOption {
        type = attrsOf str;
        default = { };
        example = {
          windows = ''
            echo hello
          '';
        };
        description = ''
          hook before start
        '';
      };
      postHook = mkOption {
        type = attrsOf str;
        default = { };
        example = {
          windows = ''
            echo hello
          '';
        };
        description = ''
          hook after shutdown
        '';
      };
    };
  };
in
{
  options.virtualisation.vfio = {
    enable = mkEnableOption "VFIO Configuration";
    IOMMUType = mkOption {
      type = types.enum [ "intel" "amd" "both" ];
      example = "intel";
      description = "Type of the IOMMU used";
    };
    enableNestedVirtualization = mkOption {
      type = types.bool;
      default = false;
      example = true;
      description = "enable nested virtualisation";
    };
    devices = mkOption {
      type = types.listOf (types.strMatching "[0-9a-f]{4}:[0-9a-f]{4}");
      default = [ ];
      example = [ "10de:1b80" "10de:10f0" ];
      description = "PCI IDs of devices to bind to vfio-pci";
    };
    deviceDomains = mkOption {
      type = types.listOf (types.strMatching "[0-9]{4}:[0-9]{2}:[0-9]{2}.[0-9]");
      default = [ ];
      example = [ "0000:01:00.0" "0000:01:00.1" ];
      description = "PCI Domains of devices to bind to vfio-pci";
    };
    disableEFIfb = mkOption {
      type = types.bool;
      default = false;
      example = true;
      description = "Disables the usage of the EFI framebuffer on boot.";
    };
    blacklistNvidia = mkOption {
      type = types.bool;
      default = false;
      description = "Add Nvidia GPU modules to blacklist";
    };
    ignoreMSRs = mkOption {
      type = types.bool;
      default = false;
      example = true;
      description = "Enables or disables kvm guest access to model-specific registers";
    };
    applyACSpatch = mkOption {
      type = types.bool;
      default = false;
      description = ''
        If set, the following things will happen:
          - The ACS override patch is applied
          - Applies the i915-vga-arbiter patch
          - Adds pcie_acs_override=downstream to the command line
      '';
    };
    hook = mkOption {
      type = hookModules;
      default = { };
      description = "Options to configure libvirt hook.";
    };
  };
  config = mkIf cfg.enable {
    services.udev.extraRules = ''
      SUBSYSTEM=="vfio", OWNER="root", GROUP="kvm"
    '';

    boot.extraModprobeConfig = optionalString (cfg.devices != [ ]) ("options vfio-pci ids=" + (concatStringsSep "," cfg.devices));
    boot.kernelParams =
      (
        if cfg.IOMMUType == "both"
        then [
          "intel_iommu=on"
          "intel_iommu=igfx_off"
          "amd_iommu=on"
        ]
        else if cfg.IOMMUType == "intel"
        then [
          "intel_iommu=on"
          "intel_iommu=igfx_off"
        ]
        else [ "amd_iommu=on" ]
      )
      ++ (optionals cfg.applyACSpatch [
        "pcie_acs_override=downstream,multifunction"
        "pci=nomsi"
      ])
      ++ (optional cfg.disableEFIfb "video=efifb:off")
      ++ (optionals cfg.ignoreMSRs [
        "kvm.ignore_msrs=1"
        "kvm.report_ignored_msrs=0"
      ])
      ++ [ "iommu=pt" ];

    # boot.kernelModules = [ "vfio_pci" "vfio" "vfio_iommu_type1" "vfio_virqfd" ]
    boot.kernelModules = [ ]
      ++ (optionals (cfg.deviceDomains == null) [ "vfio_pci" "vfio" "vfio_iommu_type1" ])
      ++ (optionals (cfg.enableNestedVirtualization && cfg.IOMMUType == "both") [ "kvm_intel nested=1" "kvm_amd nested=1" ])
      ++ (optional (cfg.enableNestedVirtualization && cfg.IOMMUType == "intel") "kvm_intel nested=1")
      ++ (optional (cfg.enableNestedVirtualization && cfg.IOMMUType == "amd") "kvm_amd nested=1");

    boot.initrd = optionalAttrs (cfg.deviceDomains != [ ]) {
      preDeviceCommands = ''
        DEVS="${concatMapStrings (x: x + " ") cfg.deviceDomains}"
        if [ -z "$(ls -A /sys/class/iommu)" ]; then
          exit 0
        fi
        for DEV in $DEVS; do
          echo "vfio-pci" > "/sys/bus/pci/devices/''$DEV/driver_override"
        done
      '';
    };
    systemd.services = optionalAttrs (cfg.deviceDomains != [ ]) {
      vfio-load = {
        description = "Insert vfio-pci driver";
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "/run/current-system/sw/bin/modprobe -i vfio-pci";
        };
      };
    };
    # boot.initrd.kernelModules =
    #   [ "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
    boot.blacklistedKernelModules =
      optionals cfg.blacklistNvidia [ "nvidia" "nouveau" ];

    boot.kernelPatches = optionals cfg.applyACSpatch [
      {
        name = "add-acs-overrides";
        patch = pkgs.fetchurl {
          name = "add-acs-overrides.patch";
          url = "https://raw.githubusercontent.com/slowbro/linux-vfio/v5.5.4-arch1/add-acs-overrides.patch";
          #url =
          #  "https://aur.archlinux.org/cgit/aur.git/plain/add-acs-overrides.patch?h=linux-vfio&id=${acscommit}";
          sha256 = "0nbmc5bwv7pl84l1mfhacvyp8vnzwhar0ahqgckvmzlhgf1n1bii";
        };
      }
      {
        name = "i915-vga-arbiter";
        patch = pkgs.fetchurl {
          name = "i915-vga-arbiter.patch";
          url = "https://raw.githubusercontent.com/slowbro/linux-vfio/v5.5.4-arch1/i915-vga-arbiter.patch";
          #url =
          #  "https://aur.archlinux.org/cgit/aur.git/plain/i915-vga-arbiter.patch?h=linux-vfio&id=${acscommit}";
          sha256 = "1m5nn9pfkf685g31y31ip70jv61sblvxgskqn8a0ca60mmr38krk";
        };
      }
    ];

    system.activationScripts.libvirt-hooks.text = optionalString cfg.hook.enable ''
      ln -Tfs /etc/libvirt/hooks /var/lib/libvirt/hooks
    '';
    environment.etc =
      mkIf cfg.hook.enable
        ((attrsets.mapAttrs'
          (vm: value:
            attrsets.nameValuePair ("libvirt/hooks/qemu.d/" + vm + "/prepare/begin/10-pre-hook.sh") {
              text = value;
              mode = "0755";
            })
          cfg.hook.preHook)
        // (attrsets.mapAttrs'
          (vm: value:
            attrsets.nameValuePair ("libvirt/hooks/qemu.d/" + vm + "/release/end/10-post-hook.sh") {
              text = value;
              mode = "0755";
            })
          cfg.hook.postHook));
  };
}
