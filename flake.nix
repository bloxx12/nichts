{
  description = "My NixOS config flake";
  outputs = inputs: let
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    user = import ./modules/user {inherit inputs pkgs;};
  in {
    nixosConfigurations = import ./hosts inputs;

    devShells.x86_64-linux.default = pkgs.callPackage ./shell.nix {};

    formatter.x86_64-linux = pkgs.alejandra;
    packages.x86_64-linux = user.packages;

    apps.x86_64-linux = {
      default = {
        type = "app";
        program = pkgs.getExe user.packages.fish;
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

    # Helix my beloved
    helix.url = "github:helix-editor/helix";

    # I use schizofox as my personal browser. This is because I am schizophrenic.
    schizofox = {
      url = "github:schizofox/schizofox";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:gerg-l/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
