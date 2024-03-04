{ stdenv, pkgs }:

stdenv.mkDerivation rec {
  name = "Reisen cursors";

  src = ./assets/reisen-cursors;

  installPhase = ''
    mkdir -p $out/share/icons
    tar -xzf Reisen.tar.gz -C $out/share/icons
  '';

}
