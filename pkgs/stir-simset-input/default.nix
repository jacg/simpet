{ stdenv ,
  lib,
  pkgs,
  fetchgit,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "stir-simset-input";
  version = "unknown";

  src = fetchgit {
    url = "https://github.com/txusser/STIR";
    rev = "c5e5524a97b3e759126f34cb5966fadc77c43b02";
    sha256 = "sha256-Tci3Vj71+0HmxsjIX0S19Y8fUdw83nE68wzY0VIDOyk=";
  };

  buildInputs = with pkgs; [
    cmake
    boost179
    nlohmann_json
    hdf5
  ];

  meta = {
    description = "Software for use in tomographic imaging";
    longDescription = ''
      STIR is Open Source software for use in tomographic imaging. Its aim is to
      provide a Multi-Platform Object-Oriented framework for all data
      manipulations in tomographic imaging. Currently, the emphasis is on
      (iterative) image reconstruction in PET and SPECT, but other application
      areas and imaging modalities can and might be added.
    '';
    homepage = "https://depts.washington.edu/simset/html/simset_main.html";
    # TODO license = mostly apache-2.0, one file under LGPL-2.1;
    maintainers = [ lib.maintainers.jacg ];
    # TODO platforms = lib.platforms.???;
  };
})
