{ pkgs, ... }:
let
  pythonPkgs =
    ps: with ps; [
      numpy
    ];
in
{
  home = {
    packages = with pkgs; [
      (python3.withPackages pythonPkgs)
      cloc # A program that counts lines of source code
      convmv # convert encoding
      mosh # Mobile Shell
      unar # An archive unpacker program
      unzip # Extraction utility for archives compressed in .zip format
      wget # Downloader
      zip # Compressor/archiver for creating and modifying zipfiles
    ];
  };
}
