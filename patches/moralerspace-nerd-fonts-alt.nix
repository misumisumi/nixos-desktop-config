{
  stdenv,
  lib,
  fetchFromGitHub,
  python3Packages,
  parallel,
}:
let
  pythonEnv = python3Packages.python.withPackages (
    p: with p; [
      fontforge
      fonttools
      setuptools
      ttfautohint-py
    ]
  );
in
stdenv.mkDerivation rec {
  pname = "moralerspace-nerd-fonts-alt";
  version = "v1.0.2";
  src = fetchFromGitHub {
    owner = "misumisumi";
    repo = "moralerspace";
    fetchSubmodules = false;
    rev = "a633bf0a0ed54cd8a48431b879287c84762a8b8e";
    sha256 = "sha256-WA+1NidYO8SCJeAw/albPgldPs/NHOdFDN076d0fx3g=";
  };

  nativeBuildInputs = [
    pythonEnv
    parallel
  ];
  buildPhase = ''
    runHook preBuild

    bash ./make.sh

    runHook postBuild
  '';
  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/truetype/molalerspace-nerd-alt

    find ./release_files -name \*.ttf -exec cp {} $out/share/fonts/truetype/molalerspace-nerd-alt \;

    runHook postInstall
  '';

  meta = {
    inherit version;
    description = "A composite font family of monaspace and IBM Plex Sansjp";
    homepage = "https://github.com/yuru7/moralerspace";
    license = lib.licenses.ofl;
  };
}
