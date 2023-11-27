{ hostname
, pkgs
, ...
}:
let
  script = pkgs.writeShellApplication {
    name = "open-wezterm-here";
    text = ''
      exec wezterm start --cwd "$PWD" -- "$@"
    '';
  };
  cinnamon-default-terminal = ''
    [org.cinnamon.desktop.default-applications.terminal]
    exec= '${script}/bin/open-wezterm-here'
  '';
  nixos-gsettings-overrides = pkgs.cinnamon.cinnamon-gsettings-overrides.override {
    extraGSettingsOverrides = cinnamon-default-terminal;
  };
in
{
  imports = [ ../../xserver ];
  environment.sessionVariables.NIX_GSETTINGS_OVERRIDES_DIR = "${nixos-gsettings-overrides}/share/gsettings-schemas/nixos-gsettings-overrides/glib-2.0/schemas";
  services.xserver.displayManager = {
    defaultSession = "none+xsession";
  };
}
