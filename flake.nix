{
  description = "My NixOS config flake";
  outputs = inputs: let
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    user = import ./modules/user {inherit pkgs;};
    eachSystem = inputs.nixpkgs.lib.genAttrs (import inputs.systems);
    pkgsFor = inputs.nixpkgs.legacyPackages;
  in {
    nixosConfigurations = import ./hosts inputs;

    devShells.x86_64-linux.default = pkgs.callPackage ./shell.nix {};

    formatter.x86_64-linux = pkgs.alejandra;
    # packages.x86_64-linux = {inherit (user) packages;};

    packages = eachSystem (
      system: {
        inherit (import ./packages pkgsFor.${system}) helix fish;
      }
    );
    # packages = eachSystem (
    #   system: let
    #     user = import ./modules/user {pkgs = pkgsFor.${system};};
    #   in {
    #     inherit (user) packages;
    #   }
    # );

    apps = eachSystem (system: let
      user = import ./modules/user {pkgs = pkgsFor.${system};};
    in {
      default = {
        type = "app";
        program = "${user.packages.fish}/bin/fish";
      };
      helix = {
        type = "app";
        program = "${user.packages.helix}/bin/hx";
      };
    });
    # nixosModules = eachSystem (system: let
    #   user = import ./modules/user {inherit inputs;};
    # in {
    #   user = user.module;
    # });
    # nixosModules.user = user.module;
  };
  inputs = {
    # Unstable nixpkgs baby!
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    systems.url = "github:nix-systems/default-linux";

    impermanence.url = "github:nix-community/impermanence";
  };
}
