{
  _module.args = {
    inherit (import ../../sops) getEncryptFile;
  };
  imports = [
    ./system
    ./system/programs.nix
  ];
}
