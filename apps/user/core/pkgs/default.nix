{ pkgs
, ...
}:
{
  home = {
    shellAliases = {
      ls = "ls --color=auto";
      grep = "grep --color=auto";
      fgrep = "grep -F --color=auto";
      egrep = "grep -E --color=auto";
    };
    packages = with pkgs;
      [
        bc # GNU calculator
        bintools # Manipulating binaries
        btop # System monitor
        coreutils-full # GNU coreutils
        curl # Downloader
        dig # Domain name server
        duf # Show storage usage
        fd # fast find
        gptfdisk # GPT partition tools
        iperf3 # Network speed test tool
        jq # JSON processor
        killall # Process killer
        lsof # check port
        mosh # Mobile Shell
        neofetch # Fetch system info
        progress # Show progress of coreutils programs
        ripgrep # fast grep
        traceroute # Track the network route
        tree # Show file tree
        unzip
        wget # Downloader
        yq-go # YAML processor
        zip
      ];
  };
}
