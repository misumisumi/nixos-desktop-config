{ pkgs, ... }:
{
  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xfff7ffff" ];
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "nvidia-offload" ''
      export __NV_PRIME_RENDER_OFFLOAD=1
      export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export __VK_LAYER_NV_optimus=NVIDIA_only
      exec "$@"
    '')
  ];
  services = {
    switcherooControl.enable = true;
    xserver = {
      videoDrivers = [
        "amdgpu"
        "nvidia"
      ];
      deviceSection = ''
        Driver "amdgpu"
        Option "DRI" "3"
        Option "EnablePageFlip" "off"
        Option "TearFree" "false"
      '';
      extraConfig = ''
        Section "Monitor"
          Identifier "eDP"
          # Force 60Hz refresh rate to reduce power consumption
          ModeLine "1920x1080_59.99" 144.370 1920 1968 2000 2080 1080 1083 1088 1157 +hsync +vsync
          Option "PreferredMode" "1920x1080_59.99"
        EndSection
      '';
    };
  };

  hardware = {
    nvidia-container-toolkit.enable = true;
    nvidia.open = false;
    graphics.extraPackages = with pkgs; [
      libvdpau-va-gl
      vaapiVdpau
      rocmPackages.clr.icd
    ];
  };
}
