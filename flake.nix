{
  description = "Our NixOS config lol";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    schizofox.url = "github:schizofox/schizofox";
    home-manager = {
        url = "github:nix-community/home-manager/";
        inputs.nixpkgs.follows = "nixpkgs";
     };
  };

  outputs = inputs @ { self, nixpkgs, nur, home-manager, ... }: 
    let
      inherit (self) outputs;
      mkSystem = {
          hostname, 
          modules ? [],
          user-configs ? [],
          system ? "x86_64-linux"
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
          vlaptop = mkSystem {
            hostname = "nixos";
            modules = [./hosts/vali/laptop ./modules/vali];
            user-configs = [{
                name = "vali";
                config = ./homes/vali/vlaptop.nix;
            }];
          };
          vdesktop = mkSystem {
              hostname = "nixos";
              modules = [ ./hosts/vali/desktop];
              user-configs = [{
                  name = "vali";
                  config = ./homes/vali/vdesktop.nix;
              }];
          };
        };

  };

}
