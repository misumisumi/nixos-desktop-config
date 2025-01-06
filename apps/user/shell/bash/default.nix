{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    historyControl = "ignoreboth";
    historyIgnore = [
      "builtin cd *"
      "cd *"
      "history *"
      "kill *"
      "ls *"
      "mkdir *"
      "pkill *"
      "rm *"
    ];
  };
}
