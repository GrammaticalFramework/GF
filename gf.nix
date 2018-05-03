let pkgs = import <nixpkgs> {}; in rec {
  gf = pkgs.haskellPackages.callPackage ./default.nix {};
}
