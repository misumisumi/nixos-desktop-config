{ self, inputs, ... }:
let
  settings =
    {
      hostname,
      user,
      system ? "x86_64-linux",
      homeDirectory ? "",
      scheme ? "",
      colorTheme ? "tokyonight-moon",
      useNixOSWallpaper ? true,
      excludeShells ? [ ],
      wm ? "",
    }:
    let
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      inherit (inputs.nixpkgs) lib;
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit
          self
          inputs
          hostname
          user
          scheme
          colorTheme
          excludeShells
          homeDirectory
          useNixOSWallpaper
          wm
          ;
      };
      modules = [
        inputs.catppuccin.homeManagerModules.catppuccin
        inputs.flakes.homeManagerModules.default
        inputs.nvimdots.homeManagerModules.nvimdots
        inputs.sops-nix.homeManagerModules.sops
        inputs.spicetify-nix.homeManagerModules.default
        self.homeManagerModules.dotfiles
        self.homeManagerModules.zinit
        self.homeManagerModules.zotero
        (
          { config, ... }:
          {
            imports = [
              ../settings/user
              ../settings/user/nixpkgs
            ] ++ lib.optional (lib.pathExists ../users/${user}) ../users/${user};
            dotfilesActivation = true;
            home.stateVersion = config.home.version.release;
          }
        )
      ];
    };
in
{
  core = settings {
    hostname = "system";
    user = "hm-user";
    scheme = "core";
    colorTheme = "tokyonight-moon";
    excludeShells = [ "bash" ];
  };
  small = settings {
    hostname = "system";
    user = "hm-user";
    scheme = "small";
    colorTheme = "tokyonight-moon";
    excludeShells = [ "bash" ];
  };
  medium = settings {
    hostname = "system";
    user = "hm-user";
    scheme = "medium";
    colorTheme = "tokyonight-moon";
    excludeShells = [ "bash" ];
  };
  full = settings {
    hostname = "system";
    user = "hm-user";
    scheme = "full";
    colorTheme = "tokyonight-moon";
    excludeShells = [ "bash" ];
  };
  test = settings {
    hostname = "liveimg";
    user = "hm-user";
    scheme = "full";
    colorTheme = "tokyonight-moon";
    wm = "qtile";
  };
}
