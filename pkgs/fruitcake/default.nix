{ stdenvNoCC ,
  lib,
  pkgs,
  fetchurl,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "fruitcake";
  version = "unknown";

  builder = ../fetch-from-mibiolab-builder.sh;
  artefact = "fruitcake.zip";
  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
  outputHash = "ApRV3WEPd7DSwp1wGb8xOhHglCvpJ1ZbObUQODN6UAU=";

  installFetched = ''
    mkdir -p $out/bin
    mkdir -p $out/lib
    install -D        fruitcake/bin/*      $out/bin
    install -D -m=666 fruitcake/book/lib/* $out/lib
  '';

  buildInputs = with pkgs; [
    openssh
    sshpass
    unzip
  ];

})
