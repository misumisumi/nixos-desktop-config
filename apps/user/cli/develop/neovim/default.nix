# This is need `https://github.com/ayamir/nvimdots`
{
  inputs,
  config,
  pkgs,
  ...
}:
{
  home = {
    sessionVariables.EDITOR = "nvim";
    packages = with pkgs; [
      file # File type checker
    ];
  };
  programs = {
    dotnet = {
      enable = true;
      package = pkgs.pkgs.dotnet-sdk_8;
    };
    java.enable = true;
    neovim = {
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      extraWrapperArgs = [
        "--set"
        "NPM_CONFIG_PREFIX"
        "${config.home.homeDirectory}/.local"
        "--prefix"
        "PATH"
        ":"
        "${config.home.homeDirectory}/.local/bin"
      ];
      extraPackages = with pkgs; [
        (commitlint.withPlugins (
          ps: with ps; [
            "@commitlint/config-conventional"
            commitlint-format-json
          ]
        ))
        deno
        go
        nixd
        nixfmt-rfc-style
        statix
      ];
      extraPython3Packages = ps: with ps; [ jupynium ];
      nvimdots = {
        enable = true;
        mergeLazyLock = true;
        setBuildEnv = true;
        withBuildTools = true;
        withHaskell = true;
        extraDependentPackages = with pkgs; [ icu ];
      };
    };
  };
  xdg.configFile = {
    "nvim/mason-lock.nix.json" = {
      source = inputs.nvimdots + "/mason-lock.json";
      onChange = ''
        if [ -f ${config.xdg.configHome}/nvim/mason-lock.json ]; then
          tmp=$(mktemp)
          ${pkgs.jq}/bin/jq -r -s '.[0] * .[1]' ${config.xdg.configHome}/nvim/mason-lock.json ${
            config.xdg.configFile."nvim/mason-lock.nix.json".source
          } > "''${tmp}" && mv "''${tmp}" ${config.xdg.configHome}/nvim/mason-lock.json
        else
          ${pkgs.rsync}/bin/rsync --chmod 644 ${
            config.xdg.configFile."nvim/mason-lock.nix.json".source
          } ${config.xdg.configHome}/nvim/mason-lock.json
        fi
      '';
    };
  };
}
