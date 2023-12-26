{ stdenv, pkgs }:

stdenv.mkDerivation rec {
  name = "shell-mommy";
  commit = "836eaf91d0acf9a3f0e876c4a2aeb680df4d495d";

  src = pkgs.fetchFromGitHub {
    owner = "sudofox";
    repo = "shell-mommy";
    rev = "${commit}";
    sha256 = "sha256-K9k9o0W+JQ5PfSNw0x6WFTeYzthGJSOXHyV23HYSO5M=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp shell-mommy.sh $out/bin/shell-mommy
    chmod +x $out/bin/shell-mommy
  '';

}
