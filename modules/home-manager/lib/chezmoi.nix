{ self, lib, ... }:
let
  inherit (builtins)
    all
    any
    head
    length
    readDir
    replaceStrings
    tail
    unique
    ;
  inherit (lib)
    concatLists
    filterAttrs
    hasSuffix
    importJSON
    importTOML
    init
    isAttrs
    isList
    last
    mapAttrs'
    mapAttrsToList
    nameValuePair
    pathExists
    splitString
    zipAttrsWith
    ;
  chezmoiRoot = self.outPath + "/chezmoi";
in
{
  importTOMLFromChezmoi = src: importTOML (chezmoiRoot + "/${src}");
  importJSONFromChezmoi = src: importJSON (chezmoiRoot + "/${src}");
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
      conf = if pathExists path then importTOML path else { };
    in
    conf;
  importChezmoiUserAppData =
    username:
    let
      path = chezmoiRoot + "/.chezmoidata/apps";
      files = readDir path;
      recursiveMerge =
        attrList:
        let
          f =
            attrPath:
            zipAttrsWith (
              n: values:
              if tail values == [ ] then
                head values
              else if all isList values then
                unique (concatLists values)
              else if all isAttrs values then
                f (attrPath ++ [ n ]) values
              else
                last values
            );
        in
        f [ ] attrList;
      conf = recursiveMerge (
        mapAttrsToList (x: _: importTOML (path + "/${x}")) (filterAttrs (n: _: hasSuffix ".toml" n) files)
      );
    in
    conf.apps.users.${username};
}
