{
  description = "My NixOS config flake";
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} ({withSystem, ...}: {
      systems = ["x86_64-linux"];
      imports = [
        inputs.treefmt-nix.flakeModule
        ./parts/shell.nix
        ./parts/fmt.nix
      ];

      flake = {
        nixosConfigurations = import ./hosts {inherit inputs withSystem;};
      };
    });
  inputs = {
    # what am I doing to this config help
    flake-parts.url = "github:hercules-ci/flake-parts";

    # Unstable nixpkgs baby!
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # nixpkgs for wayland
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";

    # Sandboxing
    nixpak = {
      url = "github:nixpak/nixpak";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix but better
    nix-super = {
      url = "github:privatevoid-net/nix-super";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hardware for my laptop
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Helix my beloved
    helix.url = "github:helix-editor/helix";

    # Hyprland, my main compositor
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    # Plugins for hyprland
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # Plugin to get split monitor workspaces
    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland";
    };

    treefmt-nix.url = "github:numtide/treefmt-nix";

    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-flake = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay.url = "github:nix-community/emacs-overlay";

    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Stylix my beloved
    stylix.url = "github:danth/stylix";

    # Aylur's gtk shell. Nice but I hate JS.
    ags.url = "github:Aylur/ags";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    schizofox = {
      url = "github:schizofox/schizofox";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpak.follows = "nixpak";
      };
    };

    spicetify-nix.url = "github:the-argus/spicetify-nix";
  };
}
