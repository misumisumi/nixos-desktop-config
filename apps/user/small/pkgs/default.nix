{ pkgs
, ...
}:
let
  pythonPkgs = ps:
    with ps; [
      numpy
    ];
in
{
  home = {
    packages = with pkgs;[
      (python3.withPackages pythonPkgs)
      cloc # A program that counts lines of source code
      convmv #convert encoding
      tty-clock # CLI clock
      unar # An archive unpacker program
    ];
    shellAliases = {
      tty-clock = "tty-clock -s -c -C 6";
    };
  };
}
