{
  description = "Simulation System for Emission Tomography";

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

    flake-utils.lib.eachSystem ["x86_64-linux" "i686-linux" "aarch64-linux" "x86_64-darwin"]
      (system: {
        packages =
          let pkgs = import nixpkgs {
                inherit system;
                overlays = [ self.overlay ];
              };
          in {
            inherit (pkgs) simset;
          };

        defaultPackage = self.packages.${system}.simset;

      }) // {
        checks = self.packages;
        overlay = final: prev: {
          simset = final.callPackage ./simset {};
        };
      };
}
