{
    description = "lololo";
    outputs = inputs @ { self, nixpkgs, ... }: 
    {
        inherit (nixpkgs) lib;
        nixosConfigurations = import ./hosts { inherit inputs; };
    };
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
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

        fenix = {
            url = "github:nix-community/fenix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
	
        hyprland = {
            url = "github:hyprwm/Hyprland";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        hyprlock = {
            url = "github:hyprwm/hyprlock";
            inputs.nixpkgs.follows = "nixpkgs";
          };

        split-monitor-workspaces = {
            url = "github:Duckonaut/split-monitor-workspaces";
            inputs.hyprland.follows = "hyprland";
        };
    };
}
