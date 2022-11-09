{ stdenvNoCC ,
  pkgs,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "fruitcake";
  version = "unknown";

  builder = ../../fetch-from-mibiolab-builder.sh;
  artefact = "fruitcake.zip";
  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
  outputHash = "sha256-Me4d6ZPM1w5FiWL1CiAfQlFWqgTuHtkT2rlHto4TE2U=";

  installFetched = ''
    mkdir -p $out/bin
    mkdir -p $out/lib
    install -D        fruitcake/bin/*      $out/bin
    install -D -m=444 fruitcake/book/lib/* $out/lib
    install -D        format_converters/*  $out/bin
  '';

  buildInputs = with pkgs; [
    openssh
    sshpass
    unzip
  ];

})
