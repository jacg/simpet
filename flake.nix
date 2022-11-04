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

  # inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  # inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, ... }:
    let
      packageNames = with builtins; attrNames (readDir ./pkgs);
      inherit (nixpkgs) lib;

    in flake-utils.lib.eachSystem ["x86_64-linux"] # "i686-linux" "aarch64-linux" "x86_64-darwin"]
      (system: {
        packages =
          let
            pkgs = import nixpkgs {
              inherit system;
              overlays = [ self.overlay ];
            };
          in lib.genAttrs packageNames (name: pkgs."${name}");
      }) // {
      overlay = final: prev:
        lib.genAttrs packageNames (name:
          final.callPackage (./pkgs + "/${name}") {});
    };
}
