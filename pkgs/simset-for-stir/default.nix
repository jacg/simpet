{ stdenv ,
  lib,
  fetchurl
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "simset";
  version = "2.9.2";

  src = fetchurl {
    url = "http://depts.washington.edu/simset/downloads/phg.${finalAttrs.version}.tar.Z";
    sha256 = "sha256-dHie2r00qTFY1+QWuxcCqbkgT/BJp+77EKdF4y1MNMM=";
  };

  preBuild = ''
     # Tell makefile where it is being run
     substituteInPlace make.files/simset.make --replace "/Users/useruser/Desktop/${finalAttrs.version}" $PWD

     # Comment out Darwin OS_CFLAGS  TODO: make platform-dependent
     substituteInPlace make.files/simset.make --replace "OS_CFLAGS = -DDARWIN -g" "# OS_CFLAGS = -DDARWIN -g"

     # Uncomment Linux OS_CFLAGS  TODO: make platform-dependent
     substituteInPlace make.files/simset.make --replace "# OS_CFLAGS = -DGEN_UNIX -DLINUX" "OS_CFLAGS = -DGEN_UNIX -DLINUX"

     # 64-bit support TODO: make platform-dependent
     substituteInPlace make.files/simset.make --replace "/* #define LB_TYPE_USE_SYS_INTS */" "#define LB_TYPE_USE_SYS_INTS"
  '';

  buildPhase = ''
     runHook preBuild
    ./make_all.sh
     #runHook postBuild
  '';

  installPhase = ''
    install -d $out/bin
    install -D bin/* $out/bin
  '';

  doCheck = false;

  checkPhase = ''
    cd samples/fastTest
    ./runFast.sh
    ./resultsFast.sh
    cd -
  '';

  meta = {
    description = "Simulation System for Emission Tomography";
    longDescription = ''
      The SimSET package uses Monte Carlo techniques to model the physical
      processes and instrumentation used in emission imaging. First released in
      1993, SimSET has become a primary resource for many nuclear medicine
      imaging research groups around the world. The University of Washington
      Imaging Research Laboratory is continuing to develop SimSET, adding new
      functionality and utilities. The direction of development is driven partly
      by our own requirements and partly by those of our users.

      SimSET is freely available. [...] We ask that all new users
      register, so that we can keep everyone up to date with the latest software
      and any new developments. We also keep a database of resources for SimSET,
      including digital phantoms and set-up files, to which users are invited to
      contribute.
    '';
    homepage = "https://depts.washington.edu/simset/html/simset_main.html";
    # TODO license = ???;
    maintainers = [ lib.maintainers.jacg ];
    # TODO platforms = lib.platforms.???;
  };
})
