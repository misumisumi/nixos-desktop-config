{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      bc # GNU calculator
      bintools # Manipulating binaries
      coreutils-full # GNU coreutils
      curl # Downloader
      duf # Show storage usage
      gptfdisk # GPT partition tools
      killall # Process killer
      progress # Show progress of coreutils programs
      tree # Show file tree
      yq # YAML processor
    ];
  };
}
