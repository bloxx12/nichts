{inputs, ...}: let
  inherit (inputs) nixpkgs;
  nixpkgsPath = nixpkgs.outPath;
in {
  # Big thanks to Dianimo for this!
  nix = {
    registry = {
      nixpkgs.flake = inputs.nixpkgs;
      default.flake = inputs.nixpkgs;
    };

    nixPath = [
      "nixpkgs=${nixpkgsPath}"
      "n=${nixpkgsPath}"
      "default=${nixpkgsPath}"
    ];
  };
}
