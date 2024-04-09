{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url= "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    schizofox.url="github:schizofox/schizofox";
    home-manager = {
        url = "github:nix-community/home-manager/";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };

  outputs = inputs @ { self, nixpkgs, nur, home-manager, ...}:
    let
      inherit (self) outputs;
      mkSystem = {
          hostname,
          modules ? [],
          user-configs ? [ { name = "vali"; config = ./home/vali/common.nix; }],
          system ? "x86_64-linux"
          #overlays ? import -/overlays/packages.nix
      }:
        let
          profile-config = { inherit hostname system modules user-configs; };
        in
        nixpkgs.lib.nixosSystem {
            inherit modules;
            specialArgs = { inherit inputs outputs profile-config; };
        };

        mkHome = user: modules: pkgs: home-manager.lib.homeManagerConfiguration {
          inherit modules pkgs user;
          extraSpecialArgs = { inherit inputs outputs user; };
        };
    in {
        nixpkgs.config.allowUnfree = true;
        nixosConfigurations = {
            laptop = mkSystem {
              hostname = "nixos";
              modules = [./hosts/laptop];
              user-configs = [{
                  name = "vali";
                  config = ./home/vali/laptop.nix;
                }];
            };
            xfce = mkSystem {
                hostname = "nixos";
                modules = [ ./hosts/xfce ];
                user-configs = [{
                    name = "vali";
                    config = ./home/vali/xfce.nix;
                  }];
              };
          };
        homeManagerConfiguration = {
            "vali@laptop" = mkHome "vali" [ home/vali/laptop.nix ] nixpkgs.legacyPackages."x86_64-linux";
          };
      };
}
