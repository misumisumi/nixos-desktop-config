{ pkgs, ... }:

{
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
