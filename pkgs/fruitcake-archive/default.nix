{ stdenvNoCC,
  pkgs,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "fruitcake-archive";
  version = "unknown";

  builder = ../../fetch-from-mibiolab-builder.sh;
  artefact = "fruitcake.zip";
  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
  outputHash = "sha256-/QWSmFQEQg791Sz8D0WjtYhG7UYAk40rcYry+BRiFa0=";

  installFetched = ''
    mkdir -p $out
    mv fruitcake $out/
  '';

  buildInputs = with pkgs; [
    openssh
    sshpass
    unzip
  ];

})
