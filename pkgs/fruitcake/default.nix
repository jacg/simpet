{ stdenvNoCC ,
  lib,
  pkgs,
  fetchurl,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "fruitcake";
  version = "unknown";

  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
  outputHash = "sha256-ApRV3WEPd7DSwp1wGb8xOhHglCvpJ1ZbObUQODN6UAU=";

  builder = ./builder.sh;

  buildInputs = with pkgs; [
    openssh
    sshpass
    unzip
  ];

})
