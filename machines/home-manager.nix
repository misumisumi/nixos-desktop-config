{ self, inputs, ... }:
with builtins;
let
  inherit (inputs.nixpkgs) lib;
  settings =
    {
      hostname,
      user,
      system ? "x86_64-linux",
      homeDirectory ? "",
      schemes ? [ ],
      colorTheme ? null,
      useNixOSWallpaper ? true,
    }:
    let
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit
          self
          inputs
          hostname
          user
          homeDirectory
          schemes
          colorTheme
          useNixOSWallpaper
          ;
      };
      modules = [
        inputs.catppuccin.homeModules.catppuccin
        inputs.flakes.homeManagerModules.default
        inputs.nvimdots.homeManagerModules.nvimdots
        inputs.sops-nix.homeManagerModules.sops
        inputs.spicetify-nix.homeManagerModules.default
        self.homeManagerModules.default
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
  presetAndShell =
    let
      presets = lib.filterAttrs (n: v: v == "directory") (builtins.readDir ../apps/user/presets);
    in
    lib.flatten (
      lib.mapAttrsToList (n: v: [
        n
        "${n}-bash"
        "${n}-zsh"
      ]) presets
    );
in
listToAttrs (
  map (name: {
    inherit name;
    value =
      let
        preset = head (lib.splitString "-" name);
        shell = tail (lib.splitString "-" name);
      in
      settings {
        hostname = "system";
        user = "hm-user";
        colorTheme = "tokyonight-moon";
        schemes = [
          "presets/${preset}"
        ] ++ lib.optional (shell != [ ]) "shell/${shell}";
      };
  }) presetAndShell
)
