{ stdenvNoCC ,
  lib,
  pkgs,
  fetchurl,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "simpet-data";
  version = "unknown";

  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
  outputHash = "-ORid7lXn2OYfALlBbGAKEOpbXT4UDa5GgbX9MksgTSQ=";

  builder = ./builder.sh;

  buildInputs = with pkgs; [
    openssh
    sshpass
    unzip
  ];

})
