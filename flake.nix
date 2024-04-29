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

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nur = {
            url = "github:nix-community/NUR";
            #inputs.nixpkgs.follows = "nixpkgs";
        };

        agenix.url = "github:ryantm/agenix";

        schizofox = {
            url = "github:schizofox/schizofox";
            inputs = {
                nixpkgs.follows = "nixpkgs";
            };
        };

        neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

        nixvim = {
            url = "github:nix-community/nixvim";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        fenix = {
            url = "github:nix-community/fenix";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        split-monitor-workspaces = {
            url = "github:Duckonaut/split-monitor-workspaces";
#            inputs.hyprland.follows = "hyprland";
        };
    };
}
