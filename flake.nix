{
    description = "lololo";
    outputs = inputs @ { self, nixpkgs, ... }: 
    {
        inherit (nixpkgs) lib;
        nixosConfigurations = import ./hosts { inherit inputs; };
    };
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nur.url = "github:nix-community/NUR";

        agenix.url = "github:ryantm/agenix";

        schizofox = {
            url = "github:schizofox/schizofox";
            inputs = {
                nixpkgs.follows = "nixpkgs";
            };
        };

        fenix = {
            url = "github:nix-community/fenix";
            inputs.nixpkgs.follows = "nixpkgs";
          };
    };
}
