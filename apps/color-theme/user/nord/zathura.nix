# Copyright (c) 2021 Lokesh Krishna
# MIT License
# https://github.com/lokesh-krishna/dotfiles
{ lib, ... }:
{
  programs.zathura.extraConfig = lib.mkBefore ''
    set default-fg "#eceff4"
    set default-bg "#2e3440"

    set completion-bg "#3b4252"
    set completion-fg "#eceff4"
    set completion-highlight-bg "#4c566a"
    set completion-highlight-fg "#eceff4"
    set completion-group-bg "#3b4252"
    set completion-group-fg "#88c0d0"

    set statusbar-fg "#eceff4"
    set statusbar-bg "#3b4252"
    set statusbar-h-padding 10
    set statusbar-v-padding 10

    set notification-bg "#2e3440"
    set notification-fg "#eceff4"
    set notification-error-bg "#2e3440"
    set notification-error-fg "#bf616a"
    set notification-warning-bg "#2e3440"
    set notification-warning-fg "#ebcb8b"
    set selection-notification "true"

    set inputbar-fg "#eceff4"
    set inputbar-bg "#3b4252"

    set recolor "true"
    set recolor-lightcolor "#2e3440"
    set recolor-darkcolor "#d8dee9"

    set index-fg "#eceff4"
    set index-bg "#2e3440"
    set index-active-fg "#eceff4"
    set index-active-bg "#4c566a"

    set render-loading-bg "#2e3440"
    set render-loading-fg "#eceff4"

    set highlight-color rgba(255,199,119,0.5)
    set highlight-active-color rgba(195,232,141,0.5)

    set adjust-open "width"
  '';
}
