{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    historyIgnore = [
      "rm *"
      "ls *"
      "pkill *"
      "kill *"
      "history *"
      "trans *"
    ];
  };
}
