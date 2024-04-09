{
  description = "Our NixOS config lol";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nur.url = "github:nix-community/NUR";
    schizofox.url = "github:schizofox/schizofox";
    flake-parts = {
        url = "github:hercules-ci/flake-parts";
        inputs.nixpkgs.lib.follows = "nixpkgs";
    };
    home-manager = {
        url = "github:nix-community/home-manager/";
        inputs.nixpkgs.follows = "nixpkgs";
     };
  };

  outputs = inputs @ { self, nixpkgs, nur, home-manager, ... }: {
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

  };

}
