{
  lib,
  pkgs,
  config,
  user,
  inputs,
  system,
  ...
}:
let
  inherit (config.lib.ndchm.chezmoi) importChezmoiUserAppData;
  inherit (importChezmoiUserAppData user) mcp gemini-cli;
  inherit (builtins) toJSON;
  inherit (lib)
    getExe
    getExe'
    last
    mapAttrs
    splitString
    ;
in
{
  home.packages =
    with pkgs;
    let
      wrapExe =
        p:
        let
          exeName = last (splitString "/" (getExe p));
        in
        #NOTE: API keys are secret, so I don't export to global env
        writeShellScriptBin "${exeName}" ''
          if [ -f "${config.home.homeDirectory}/.env" ]; then
            export $(${getExe' pkgs.gnugrep "grep"} -v '^#' ${config.home.homeDirectory}/.env | xargs)
          fi
          ${getExe' p exeName} "$@"
        '';
    in
    (map wrapExe [
      aichat
      github-copilot-cli
      mcp-hub
    ])
    ++ [
      # mcp servers
      mcp-nixos
      github-mcp-server
      paper-search-mcp
      mcp-server-filesystem
      mcp-server-memory
      (inputs.mcp-servers-nix.packages.${system}.mcp-server-fetch.overrideAttrs (old: {
        postPatch = ''
          substituteInPlace src/mcp_server_fetch/server.py \
          --replace-fail "AsyncClient(proxies=" "AsyncClient(proxy="
        '';
      }))
      inputs.mcp-servers-nix.packages.${system}.mcp-server-git
      inputs.mcp-servers-nix.packages.${system}.context7-mcp
    ];
  xdg.configFile = {
    "aichat/roles" = {
      source = ./roles;
      recursive = true;
    };
    "mcphub/servers.json".text = toJSON mcp;
    ".copilot/mcp-config.json".text = toJSON {
      mcpServers = mapAttrs (
        _: x:
        {
          type = "local";
          tools = [ "*" ];
          args = [ ];
        }
        // x
      ) mcp.mcpServers;
    };
  };
  programs.gemini-cli = {
    enable = true;
    defaultModel = "gemini-2.5-flash";
    settings = gemini-cli.settings // mcp;
  };
}
