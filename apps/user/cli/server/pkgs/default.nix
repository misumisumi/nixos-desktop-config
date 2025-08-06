{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dig # Domain name server
    iperf3 # Network speed test tool
    lsof # check port
    tcpdump # network packet analyzer
    traceroute # Track the network route
  ];
}
