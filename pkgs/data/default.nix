{ stdenvNoCC ,
  pkgs,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "simpet-data";
  version = "unknown";

  builder = ../../fetch-from-mibiolab-builder.sh;
  artefact = "Data.zip";
  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
  outputHash = "sha256-ORid7lXn2OYfALlBbGAKEOpbXT4UDa5GgbX9MksgTSQ=";

  installFetched = ''
    mkdir -p $out
    mv Data $out/
  '';

  buildInputs = with pkgs; [
    openssh
    sshpass
    unzip
  ];

})
