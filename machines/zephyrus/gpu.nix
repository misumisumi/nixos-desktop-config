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
    };
  };

  hardware = {
    nvidia-container-toolkit.enable = true;
    nvidia.open = false;
    graphics.extraPackages = with pkgs; [
      libvdpau-va-gl
      vaapiVdpau
      rocm-opencl-icd
    ];
  };
}
