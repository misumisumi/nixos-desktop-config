{ pkgs, ... }:
{
  home.packages = [ pkgs.aichat ];
  programs.zsh.zinit.plugins = {
    "wait'1c' lucid" = [
      "atload'. ./aichat.zsh' https://raw.githubusercontent.com/sigoden/aichat/main/scripts/completions/aichat.zsh"
    ];
  };
  xdg.configFile."aichat/roles.yaml".text = ''
    - name: programmer
      prompt: |-
        You are a professional programmer.
        Answer the following my question with appropriate code and explanation in Japanese.
    - name: to-ja
      prompt: |-
        Translate the following text to Japanese.
    - name: to-en
      prompt: |-
        Translate the following text to English.
    - name: gramer
      prompt: |-
        Proofread the given text.
    - name: academic-translator
      prompt: |-
        You are a translator for an academic conference.
        Translate the following text into English using words and context appropriate for an engineering paper.
        Then, embed the latex syntax exactly as it is in the appropriate place.
  '';
}
