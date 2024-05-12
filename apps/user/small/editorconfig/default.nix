{ config
, ...
}:
{
  editorconfig = {
    enable = true;
  };
  home = {
    file."${config.home.homeDirectory}/.editorconfig" = {
      enable = true;
      source = ./.editorconfig;
    };
  };
}
