{ }:
let
  nixpkgsSets = import ./.ci/nixpkgs.nix;
  inherit (nixpkgsSets) nixos1809 nixos2003 nixos2205 unstable;
  inherit (nixos2205) lib;
  inherit (nixos2205.haskell.lib) doJailbreak dontCheck;
  sharedOverrides = self: super: {
    monad-logger = self.callHackageDirect
      { pkg = "monad-logger";
        ver = "0.3.40";
        sha256 = "Qusx/ADX5zOHXT4S390nkoeyd1r8brVTljvIS0fYOuQ=";
      } {};
  };
  ghcs = rec {
    ghc865 = nixos2003.haskell.packages.ghc865.override {
      overrides = sharedOverrides;
    };
    ghc884 = nixos2003.haskell.packages.ghc884.override {
      overrides = sharedOverrides;
    };
    ghc8102 = unstable.haskell.packages.ghc8102.override {
      overrides = sharedOverrides;
    };
    ghc924 = nixos2205.haskell.packages.ghc924.override {
      overrides = sharedOverrides;
  };};
in
  lib.mapAttrs (_: ghc: ghc.callCabal2nix "monad-logger-extras" ./. {}) ghcs
