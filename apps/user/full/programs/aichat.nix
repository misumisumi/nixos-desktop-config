{ pkgs, ... }:
{
  home.packages = [ pkgs.aichat ];
  xdg.configFile."aichat/roles.yaml".text = ''
    - name: programmer
      prompt: |-
        You are a professional programmer.
        Answer the following my question with appropriate code and explanation in Japanese.
    - name: translator
      prompt: |-
        Translate the following text to Japanese.
    - name: academic-translator
      prompt: |-
        You are a translator for an academic conference.
        Translate the following text into Japanese using words and context appropriate for an engineering paper.
        Then, embed the latex syntax exactly as it is in the appropriate place.
  '';
}
