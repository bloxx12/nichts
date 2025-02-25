{
  description = "My NixOS config flake";
  outputs = inputs: let
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    user = import ./modules/user {inherit pkgs;};
  in {
    nixosConfigurations = import ./hosts inputs;

    devShells.x86_64-linux.default = pkgs.callPackage ./shell.nix {};

    formatter.x86_64-linux = pkgs.alejandra;
    packages.x86_64-linux = user.packages;

    apps.x86_64-linux = {
      default = {
        type = "app";
        program = "${user.packages.fish}/bin/fish";
      };
      helix = {
        type = "app";
        program = "${user.packages.helix}/bin/hx";
      };
    };
    nixosModules = {
      user = user.module;
    };
  };
  inputs = {
    # Unstable nixpkgs baby!
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    impermanence.url = "github:nix-community/impermanence";
  };
}
