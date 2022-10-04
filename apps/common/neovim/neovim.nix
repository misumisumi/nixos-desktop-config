{ pkgs, ... }:

{
  programs = {
    neovim = {
      enable = true;
      extraPackages = with pkgs; [
        efm-langserver
        rnix-lsp
        diagnostic-languageserver
        black
        pylint
        vim-vint
        yamllint
      ];

      extraPython3Packages = ps: with ps; [
        isort
        docformatter
      ];

      coc = {
        enable = true;
        pluginConfig = ''
        '';
        settings = ''
          "languageserver": {
            "efm": {
              "command": "efm-langserver",
              "args": [],
              // custom config path
              // "args": ["-c", "/path/to/your/config.yaml"],
              "filetypes": ["vim"]
                }
              },
           "languageserver": {
               "nix": {
                   "command": "rnix-lsp",
                   "filetypes": ["nix"]
               }
           },
           "diagnostic-languageserver.formatFiletypes": {
              "python": ["black", "isort", "docformatter"]
            },
           "diagnostic-languageserver.formatters": {
             "black": {
               "command": "black",
               "args": ["-q", "-"]
             },
             "isort": {
               "command": "isort",
               "args": ["-q", "-"]
             },
             "docformatter": {
               "command": "docformatter",
               "args": ["-"]
             }
           },
           "diagnostic-languageserver.filetypes": {
             "python": "pylint",
             "vim": "vint",
             "markdown": "markdownlint",
             "sh": "shellcheck",
             "yaml": "yamllint",
             "systemd": "systemd-analyze"
           },
           "diagnostic-languageserver.linters": {
             "pylint": {
               "sourceName": "pylint",
               "command": "pylint",
               "args": [
                 "--output-format",
                 "text",
                 "--score",
                 "no",
                 "--msg-template",
                 "'{line}:{column}:{category}:{msg} ({msg_id}:{symbol})'",
                 "%file"
               ],
               "formatPattern": [
                 "^(\\d+?):(\\d+?):([a-z]+?):(.*)$",
                 {
                   "line": 1,
                   "column": 2,
                   "security": 3,
                   "message": 4
                 }
               ],
               "rootPatterns": [".git", "pyproject.toml", "setup.py"],
               "securities": {
                 "informational": "hint",
                 "refactor": "info",
                 "convention": "info",
                 "warning": "warning",
                 "error": "error",
                 "fatal": "error"
               },
               "offsetColumn": 1,
               "formatLines": 1
             }
           }
        '';
      };
    };
  };
}
