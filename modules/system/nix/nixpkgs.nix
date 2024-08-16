# taken from raf
{
  # Global nixpkgs configuration. This is ignored if nixpkgs.pkgs is set
  # which is a case that should be avoided. Everything that is set to configure
  # nixpkgs must go here.
  nixpkgs = {
    # Configuration reference:
    # <https://nixos.org/manual/nixpkgs/unstable/#chap-packageconfig>
    hostPlatform = "x86_64-linux";
    config = {
      # Disallow broken packages to be built.       allowBroken = false;
      allowUnsupportedSystem = true;

      # Allow unfree packages
      allowUnfree = true;

      # Default to none, add more as necessary. This is usually where
      # electron packages go when they reach EOL.
      permittedInsecurePackages = [];

      # Nixpkgs sets internal package aliases to ease migration from other
      # distributions easier, or for convenience's sake. Even though the manual
      # and the description for this option recommends this to be true, I prefer
      # explicit naming conventions, i.e., no aliases.
      allowAliases = false;

      # List of derivation warnings to display while rebuilding.
      #  See: <https://github.com/NixOS/nixpkgs/blob/master/pkgs/stdenv/generic/check-meta.nix>
      # NOTE: "maintainerless" can be added to emit warnings
      # about packages without maintainers but it seems to me
      # like there are more packages without maintainers than
      # with maintainers, so it's disabled for the time being.
      showDerivationWarnings = [];
    };
  };
}
