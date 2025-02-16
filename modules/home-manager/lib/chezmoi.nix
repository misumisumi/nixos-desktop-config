{ self, lib, ... }:
let
  inherit (builtins)
    all
    any
    length
    readDir
    replaceStrings
    ;
  inherit (lib)
    filterAttrs
    hasSuffix
    init
    last
    mapAttrs'
    nameValuePair
    splitString
    ;
in
{
  _module.args =
    let
      chezmoiRoot = self.outPath + "/chezmoi";
    in
    {
      importTOMLFromChezmoi = src: lib.importTOML (chezmoiRoot + "/${src}");
      importJSONFromChezmoi = src: lib.importJSON (chezmoiRoot + "/${src}");
      importFilesFromChezmoi =
        {
          chezmoiSrc,
          recursive ? false,
          ignores ? [ ],
        }:
        let
          source = chezmoiRoot + "/${chezmoiSrc}";
          replaceDot = n: replaceStrings [ "dot_" ] [ "." ] n;
          rmState = n: last (splitString "_" (replaceDot n));
          _parent =
            let
              split = splitString "/" chezmoiSrc;
            in
            if recursive then
              last split
            else if length split > 1 then
              last (init split)
            else
              ".";
          notParent = [
            "."
            "chezmoi"
            "dot_config"
          ];
          parent = if any (n: _parent == n) notParent then "" else "${rmState _parent}/";
        in
        if recursive then
          let
            # .tmpl file is a template for chezmoi so we don't want to include it
            contents = filterAttrs (n: _: all (x: n != x) ignores && !hasSuffix "tmpl" n) (readDir source);
          in
          mapAttrs' (n: v: nameValuePair "${parent}${rmState n}" { source = source + "/${n}"; }) contents
        else
          {
            "${parent}${rmState chezmoiSrc}" = {
              inherit source;
            };
          };
      importChezmoiData =
        fpath:
        let
          path = chezmoiRoot + "/.chezmoidata/${fpath}";
          conf = if lib.pathExists path then lib.importTOML path else { };
        in
        conf;
      importChezmoiUserAppData =
        username:
        let
          path = chezmoiRoot + "/.chezmoidata/apps/${username}.toml";
          conf = if lib.pathExists path then lib.importTOML path else { };
        in
        conf.apps.users.${username};
    };
}
