let
  # We import the package hierarchy from the NIX_PATH.
  pkgs = import <nixpkgs> {};

  #
  # The `cgi` package has some out-of-date upper bounds.
  # Instead of fixing that upstream, we can use the "jailbreak"
  # function in Nix, which patches away the upper bounds.
  #
  # This isn't ideal, but it lets us build the dependency.
  #
  jailbreak = pkgs.haskell.lib.doJailbreak;
  haskellPackages = pkgs.haskellPackages.extend (self: super: {
    cgi = jailbreak super.cgi;
  });

in {
  gf = haskellPackages.callPackage (import ./default.nix) {};
}
