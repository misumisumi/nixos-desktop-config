{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      bc # GNU calculator
      bintools # Manipulating binaries
      coreutils-full # GNU coreutils
      curl # Downloader
      dig # Domain name server
      duf # Show storage usage
      gptfdisk # GPT partition tools
      iperf3 # Network speed test tool
      killall # Process killer
      lsof # check port
      progress # Show progress of coreutils programs
      traceroute # Track the network route
      tree # Show file tree
      unzip
      wget # Downloader
      yq-go # YAML processor
      zip
    ];
  };
}
