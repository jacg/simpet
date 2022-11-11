{
  description = "Simplified interface to a collection of PET simulation utilities";

  # Version pinning is managed in flake.lock. Upgrading can be done with
  # something like
  #
  #    nix flake lock --update-input nixpkgs

  inputs = {
    nixpkgs     .url = "github:nixos/nixpkgs/nixos-22.05";
    flake-utils .url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    let
      packageNames = with builtins; attrNames (readDir ./pkgs);
      inherit (nixpkgs) lib;

    in flake-utils.lib.eachSystem ["x86_64-linux"] # "i686-linux" "aarch64-linux" "x86_64-darwin"]
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              self.overlay
            ];
          };
          # ----- A Python interpreter with the packages that interest us -------
          python-with-all-my-packages = (pkgs.python310.withPackages (ps: with ps; [
            nibabel
            nilearn
            #nipype # depends on pybids which is broken in nixpkgs
            pyyaml
            pexpect
          ]));
        in {
          # All the packages defined by the derivations in `./pkgs`
          # Can be accessed with
          #
          #   nix {shell,build,develop} <this-flake-identifier>#<package-name>
          #
          packages = lib.genAttrs packageNames (name: pkgs."${name}");

          # A shell which aggregates all the utilities provided by simpet.
          # Can be accessed with
          #
          #   nix develop <this-flake-identifier>
          #
          # but it is also automatically activated/deactivated when
          # entering/leaving this directory, if direnv is enabled.
          #
          devShell = pkgs.mkShell {
            # Executable packages to be added to the shell environment
            packages = with pkgs; [
              simset-for-stir
              stir-simset-input
              fruitcake
              python-with-all-my-packages
            ];
            # Build dependencies to be added to the shell environment
            inputsFrom = with pkgs; [];

            SIMPET_DATA_DIR = "${pkgs.data}/Data";

            # Isn't there a higher-level way of adding stuff to LD_LIBRARY_PATH?
            shellHook = ''
              export LD_LIBRARY_PATH=${pkgs.fruitcake}/lib:$LD_LIBRARY_PATH
            '';
          };
        }) // {
        overlay = final: prev:
          lib.genAttrs packageNames (name:
            final.callPackage (./pkgs + "/${name}") {});
      };
}
