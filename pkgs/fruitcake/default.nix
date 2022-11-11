{ stdenv,
  pkgs,
  autoPatchelfHook
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "fruitcake";
  version = "unknown";
  src = "${pkgs.fruitcake-archive}/fruitcake";

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  installPhase = ''
     install -m 555 -D      bin/* -t $out/bin
     install -m 444 -D book/lib/* -t $out/lib
  '';

})
