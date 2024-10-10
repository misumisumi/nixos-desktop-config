{
  home = {
    sessionVariables = {
      ls = "ls --color=auto";
      grep = "grep --color=auto";
      fgrep = "grep -F --color=auto";
      egrep = "grep -E --color=auto";
    };
  };
  programs =
    let
      removePath = ''
        # qtileやkittyなどwrap環境内で作業することが必要な時に依存関係のPATHを外す処理
        # (依存関係のPATHが追記された状態を解消してクリーンな状態に戻す)
        # direnvでは問題なかったがnix-shellやnix shellでパスが追記されない
        # (PATH追記後にSHELLが起動するため)問題があったため、シェルの深さで実行の有無を決める
        if [ -n "$DESKTOP_SESSION" ] && [ "$SHLVL" -eq 2 ] || [ "$SHLVL" -eq 1 ]; then
        	PATH=$(echo "$PATH" | sed 's/\/nix\/store\/[a-zA-Z._0-9-]\+\/bin:\?//g' | sed 's/:$//')
        fi
      '';
    in
    {
      bash.initExtra = removePath;
      zsh.initExtra = removePath;
    };
}
