{
  lib,
  pkgs,
  config,
  user,
  ...
}:
let
  inherit (config.lib.ndchm.chezmoi) importChezmoiUserAppData getChezmoiFilePath;
  appData = importChezmoiUserAppData user;
  inherit (appData) mcp opencode omo;
  omoModels = appData.omo_models or { };
  inherit (builtins) toJSON;
  inherit (lib)
    filterAttrs
    getExe
    getExe'
    last
    mapAttrs
    splitString
    ;
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
        oh-my-openagent
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
        context7-mcp
        github-mcp-server
        mcp-nixos
        mcp-server-git
        mcpvault
        paper-search-mcp
        codebase-memory-mcp
      ];
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
      ".omo/omo.jsonc".text = toJSON omo.settings;
      ".omo/agent/settings.jsonc".text = toJSON omo.agent.settings;
    }
    // lib.optionalAttrs (omoModels != { }) {
      # omo native (senpi) reads providers from its own models.json, not opencode.json
      ".omo/agent/models.json" = {
        force = true;
        text = toJSON omoModels;
      };
    };
  };
  xdg.configFile = {
    "aichat/roles" = {
      source = ./roles;
      recursive = true;
    };
    "mcphub/servers.json".text = toJSON mcp;
    "opencode/dcp.jsonc".source = getChezmoiFilePath "dot_config/opencode/dcp.jsonc";
    "opencode/plugins/cbm-augment.ts".source =
      pkgs.replaceVars ./codebase-memory-mcp/plugins/cbm-augment.ts
        {
          inherit (pkgs) codebase-memory-mcp;
        };
  };
  programs = {
    mcp = {
      enable = true;
      servers = mcp.mcpServers;
    };
    opencode = {
      enable = true;
      package = pkgs.writeShellScriptBin "opencode" ''
        if [ -f "${config.home.homeDirectory}/.env" ]; then
          export $(${getExe' pkgs.gnugrep "grep"} -v '^#' ${config.home.homeDirectory}/.env | xargs)
        fi
        export OPENCODE_ENABLE_EXA=1
        ${pkgs.opencode}/bin/opencode "$@"
      '';
      enableMcpIntegration = true;
      settings = opencode;
      agents = {
        codebase-memory-auditor = ./codebase-memory-mcp/agents/codebase-memory-auditor.md;
        codebase-memory-scout = ./codebase-memory-mcp/agents/codebase-memory-scout.md;
        codebase-memory = ./codebase-memory-mcp/agents/codebase-memory.md;
      };
      skills = {
        codebase-memory-mcp = ./codebase-memory-mcp;
      }
      // pkgs.agent-skills.github.imbad0202.academic-research-skills
      // pkgs.agent-skills.github.nanaism.yomiyasu;
    };
    github-copilot-cli = {
      enable = true;
    };
  };
}
