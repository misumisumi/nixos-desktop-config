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
        (textlint.withPlugins (ps: with ps; [
          "@proofdict/textlint-rule-proofdict"
          textlint-filter-rule-allowlist
          textlint-filter-rule-comments
          textlint-rule-preset-ja-spacing
          textlint-rule-preset-ja-technical-writing
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
