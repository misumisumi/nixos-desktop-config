{ pkgs, ... }:
{
  imports = [
    ./firefox
    ./vivaldi
  ];
  home.packages = with pkgs; [
    (google-fonts.override {
      fonts = [
        "Anton"
      ];
    })
    comic-relief
  ];
}
