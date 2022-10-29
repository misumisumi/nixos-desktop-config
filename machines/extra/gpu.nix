{ pkgs, ... }:
let
  prime-run = pkgs.writeShellScriptBin "prime-run" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in
{
  environment.systemPackages = [ prime-run ];
  services = {
    xserver = {
      videoDrivers = [
        "amdgpu"
        "nvidia"
      ];
    };
  };

  hardware = {
    opengl.extraPackages = with pkgs; [
      rocm-opencl-icd
    ];

    # nvidia = {
    #   prime = {
    #     offload.enable = true;
    #     sync.enable = false;
    #     nvidiaBusId = "PCI:1:0:0";
    #     amdgpuBusId = "PCI:4:0:0";
    #   };
    # };
  };
}
