# This is need `https://github.com/ayamir/nvimdots`
{ pkgs, ... }:
{
  home = {
    sessionVariables.EDITOR = "nvim";
    packages = with pkgs; [
      file # File type checker
    ];
  };
  programs = {
    dotnet.dev.enable = true;
    java.enable = true;
    neovim = {
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
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
}
