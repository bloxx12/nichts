{
  description = "My simple system flake, make to be understandable, clean and reproducible.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...} @ inputs: let
  pkgs = nixpkgs.legacyPackages.x86_64-linux;
   in {
    nixosConfigurations = import ./hosts {inherit inputs; };
    packages.x86_64-linux.default = pkgs.hello;
    formatters.x86_64-linux.default = pkgs.alejandra;
  };
}
