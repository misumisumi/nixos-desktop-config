{ config, ... }:
with builtins; {
  editorconfig = {
    enable = true;
  };
  home = {
    file."${config.home.homeDirectory}/.editorconfig".source = ./.editorconfig;
  };
}
