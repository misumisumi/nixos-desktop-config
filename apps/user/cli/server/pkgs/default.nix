{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dig # Domain name server
    iperf3 # Network speed test tool
    lsof # check port
    traceroute # Track the network route
  ];
}
