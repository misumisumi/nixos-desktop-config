{
  config,
  user,
  pkgs,
  ...
}:
let
  inherit (config.lib.ndchm.chezmoi) importChezmoiUserAppData importFilesFromChezmoi;
in
{
  home.packages = with pkgs; [
    git-ignore
    git-crypt
    git-secret
    github-cli
  ];
  programs =
    let
      inherit (importChezmoiUserAppData "${user}") git delta;
    in
    {
      git = {
        enable = true;
        settings = git.settings // {
          init = {
            defaultBranch = "main";
          };
          commit = {
            template = "~/.config/git/message";
          };
        };
        signing = {
          inherit (git.signing) key format signByDefault;
        };
        lfs.enable = true;
      };
      delta = {
        enable = true;
        enableGitIntegration = true;
        options = delta.git.delta;
      };
    };

  xdg.configFile = importFilesFromChezmoi {
    chezmoiSrc = "dot_config/git";
    recursive = true;
  };
}
