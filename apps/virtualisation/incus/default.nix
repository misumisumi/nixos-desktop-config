{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ lxd-to-incus ];
  virtualisation = {
    incus = {
      enable = true;
      startTimeout = 300;
    };
  };
}
