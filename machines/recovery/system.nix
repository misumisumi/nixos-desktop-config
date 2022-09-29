{
  nix = {
    # settings = {
    #   cores = "0";
    #   max-jobs = "auto";
    # };
    extraOptions = ''
      binary-caches-parallel-connections = 4
    '';
  };
}
