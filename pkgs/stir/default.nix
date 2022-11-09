{ stdenv ,
  lib,
  pkgs,
  fetchurl,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "stir";
  version = "5.0.2";

  src = fetchurl {
    url = "https://github.com/UCL/STIR/archive/refs/tags/rel_${finalAttrs.version}.tar.gz";
    sha256 = "sha256-Z8Q0x4YGsoI6R8IvGwKESllK7Mz4QsIlnAeBoZya2N4=";
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
