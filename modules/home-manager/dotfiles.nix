{
  config,
  lib,
  user,
  schemes ? [ ],
  colorTheme ? null,
  homeDirectory ? "",
  ...
}:
with builtins;
let
  removeFlavor = head (split "-" colorTheme);
  schemePaths = map (x: ../../apps/user/${x}) schemes;
in
{
  options = {
    dotfilesActivation = lib.mkEnableOption "Activate dotfiles";
  };
  imports =
    [
      ../../settings/user
    ]
    ++ schemePaths
    ++ lib.optional (colorTheme != null) ../../apps/color-theme/user/${removeFlavor};

  config = lib.mkIf config.dotfilesActivation {
    programs.home-manager.enable = true;
    assertions = [
      {
        assertion = all (x: x) (map (x: pathExists ../../apps/user/${x}) schemes);
        message = ''
          Please set list existing schemes under apps/user.
        '';
      }
      {
        assertion = colorTheme == null || pathExists ../../apps/color-theme/user/${removeFlavor};
        message = ''
          `${removeFlavor}` is not supported color theme.
          See supported color theme list in apps/user/color-theme.
        '';
      }
    ];
    home = {
      username = "${user}";
      homeDirectory = if homeDirectory == "" then "/home/${user}" else homeDirectory;
    };
    fonts.fontconfig.enable = true;
  };
}
