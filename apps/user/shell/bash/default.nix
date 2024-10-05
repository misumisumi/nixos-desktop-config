{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
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
