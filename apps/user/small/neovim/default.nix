# This is need `https://github.com/ayamir/nvimdots`
{ pkgs
, ...
}:
{
  home.sessionVariables.EDITOR = "nvim";
  programs = {
    dotnet.dev.enable = true;
    java.enable = true;
    neovim = {
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      extraPackages = with pkgs; [
        (commitlint.withPlugins (ps: with ps; [
          "@commitlint/config-conventional"
          commitlint-format-json
        ]))
        deno
        go
        nixd
        nixpkgs-fmt
        statix
      ];
      extraPython3Packages = ps: with ps; [
        jupynium
      ];
      nvimdots = {
        enable = true;
        bindLazyLock = true;
        setBuildEnv = true;
        withBuildTools = true;
        withHaskell = true;
        extraDependentPackages = with pkgs; [ icu ];
      };
    };
  };
}
