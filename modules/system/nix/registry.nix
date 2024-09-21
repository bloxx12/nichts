{inputs, ...}: {
  # Big thanks to Dianimo for this!
  nix = {
    registry = {
      nixpkgs.flake = inputs.nixpkgs;
      default.flake = inputs.nixpkgs;
    };
  };
}
