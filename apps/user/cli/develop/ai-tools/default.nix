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
  inherit (importChezmoiUserAppData user) mcp opencode;
  inherit (builtins) toJSON;
  inherit (lib)
    filterAttrs
    getExe
    getExe'
    last
    mapAttrs
    splitString
    ;

  skills = pkgs.skills.imbad0202.academic-research-skills;
in
{
  home = {
    packages =
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
            export SSL_CERT_DIR="${pkgs.cacert}/etc/ssl/certs"
            ${getExe' p exeName} "$@"
          '';
      in
      (map wrapExe [
        aichat
        mcp-hub
      ])
      ++ [
        (writeShellScriptBin "copilot-oc" ''
          export COPILOT_PROVIDER_API_KEY=$(${getExe' pkgs.gnugrep "grep"} OPENCODE_API_KEY ${config.home.homeDirectory}/.env | ${getExe' pkgs.coreutils "cut"} -d'=' -f2)
          export COPILOT_PROVIDER_TYPE=openai
          export COPILOT_PROVIDER_BASE_URL=https://opencode.ai/zen/go/v1
          export COPILOT_MODEL=deepseek-v4-flash
          ${pkgs.github-copilot-cli}/bin/copilot "$@"
        '')
        # mcp servers
        github-mcp-server
        mcp-nixos
        mcpvault
        paper-search-mcp
      ]
      ++ (
        with inputs.mcp-servers-nix.packages.${system};
        let
          postInstall =
            {
              service,
              workspace ? service,
            }:
            ''
              mv "$out/lib/node_modules/@modelcontextprotocol/servers" "$out/lib/node_modules/@modelcontextprotocol/servers-${service}"
              cp -r src "$out/lib/node_modules/@modelcontextprotocol/servers-${service}/src"
              makeWrapper "${nodejs_22}/bin/node" "$out/bin/mcp-server-${service}" \
                --add-flags "$out/lib/node_modules/@modelcontextprotocol/servers-${service}/src/${workspace}/dist/index.js"
            '';
        in
        [
          (mcp-server-filesystem.overrideAttrs (old: {
            postInstall = postInstall { service = "filesystem"; };
          }))
          (mcp-server-memory.overrideAttrs (old: {
            postInstall = postInstall { service = "memory"; };
          }))
          context7-mcp
          mcp-server-git
          mcp-server-sequential-thinking
        ]
      );
    file = {
      ".copilot/mcp-config.json".text = toJSON {
        mcpServers = mapAttrs (
          _: x:
          {
            type = "local";
            tools = [ "*" ];
            args = [ ];
          }
          // x
        ) (filterAttrs (k: _: k != "github-mcp-server") mcp.mcpServers);
      };
    };
  };
  xdg.configFile = {
    "aichat/roles" = {
      source = ./roles;
      recursive = true;
    };
    "mcphub/servers.json".text = toJSON mcp;
  };
  programs = {
    mcp = {
      enable = true;
      servers = mcp.mcpServers;
    };
    opencode = {
      enable = true;
      package = pkgs.writeShellScriptBin "opencode" ''
        export OPENCODE_ENABLE_EXA=1
        ${pkgs.opencode}/bin/opencode "$@"
      '';
      enableMcpIntegration = true;
      settings = opencode;
      inherit skills;
    };
    antigravity-cli = {
      enable = true;
      enableMcpIntegration = true;
      settings = {
        colorScheme = "tokyo night";
        enableTelemetry = false;
      };
    };
    github-copilot-cli = {
      enable = true;
    };
  };
}
