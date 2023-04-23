{pkgs, ...}:
with pkgs; [
  coreutils-full # GNU coreutils
  killall # Process killer
  pciutils # Device utils
  usbutils
  screen # Separate terminal
  wget # Downloader
  curl
  traceroute # Track the network route
  gptfdisk # GPT partition tools
]