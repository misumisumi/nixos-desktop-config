/*
System Monitor
*/
{ pkgs, ... }:

{
  programs = {
    htop = {
      enable = true;

      settings = {};
    };
  };
}
