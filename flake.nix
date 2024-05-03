{
    description = "lololo";
    outputs = inputs @ { self, nixpkgs, ... }: 
    {
        inherit (nixpkgs) lib;
        nixosConfigurations = import ./hosts { inherit inputs; };
    };
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        anyrun = {
            url = "github:Kirottu/anyrun";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        stylix.url = "github:danth/stylix";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nur = {
            url = "github:nix-community/NUR";
            #inputs.nixpkgs.follows = "nixpkgs";
        };

        agenix.url = "github:ryantm/agenix";

        neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

        fenix = {
            url = "github:nix-community/fenix";
            inputs.nixpkgs.follows = "nixpkgs";
        };

    };
}
