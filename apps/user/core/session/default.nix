{ lib, scheme, ... }:
{
  home.shellAliases = {
    ls = "ls --color=auto";
    grep = "grep --color=auto";
    fgrep = "grep -F --color=auto";
    egrep = "grep -E --color=auto";
  } // lib.optionalAttrs (scheme != "core") {
    tty-clock = "tty-clock -s -c -C 6";
  };
}
