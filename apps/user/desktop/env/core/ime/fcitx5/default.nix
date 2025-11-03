# Fcitx5 (IME) conf
{ lib, pkgs, ... }:
{
  xdg.configFile = {
    "fcitx5/profile" = {
      source = ./conf/profile;
      force = true;
    };
    "fcitx5/config" = {
      source = ./conf/config;
      force = true;
    };
    "fcitx5/conf/xim.conf".source = ./conf/xim.conf;
    "fcitx5/conf/classicui.conf" = {
      text = lib.generators.toINIWithGlobalSection { } {
        globalSection = {
          # Vertical Candidate List
          "Vertical Candidate List" = "False";
          # Use mouse wheel to go to prev or next page
          WheelForPaging = "True";
          # Font
          Font = "\"Sans 10\"";
          # Menu Font
          MenuFont = "\"Sans 10\"";
          # Tray Font
          TrayFont = "\"Sans Bold 10\"";
          # Tray Label Outline Color
          TrayOutlineColor = "#000000";
          # Tray Label Text Color
          TrayTextColor = "#ffffff";
          # Prefer Text Icon
          PreferTextIcon = "False";
          # Show Layout Name In Icon
          ShowLayoutNameInIcon = "True";
          # Use input method language to display text
          UseInputMethodLanguageToDisplayText = "True";
          # Follow system accent color if it is supported by theme and desktop
          UseAccentColor = "True";
          # Use Per Screen DPI on X11
          PerScreenDPI = "False";
          # Force font DPI on Wayland
          ForceWaylandDPI = "0";
          # Enable fractional scale under Wayland
          EnableFractionalScale = "True";
        };
      };
    };
  };
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      libsForQt5.fcitx5-qt
      fcitx5-mozc
      qt6Packages.fcitx5-configtool
    ];
  };
}
