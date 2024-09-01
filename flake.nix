{
  description = "My NixOS config flake";
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];
      imports = [
        ./hosts
        ./parts
      ];
    };
  inputs = {
    # what am I doing to this config help
    flake-parts.url = "github:hercules-ci/flake-parts";

    # Unstable nixpkgs baby!
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Sandboxing
    nixpak = {
      url = "github:nixpak/nixpak";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    helix.url = "github:helix-editor/helix";
    neovim-flake = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay.url = "github:nix-community/emacs-overlay";

    # I use schizofox as my personal browser. This is because I am schizophrenic.
    schizofox = {
      url = "github:schizofox/schizofox";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpak.follows = "nixpak";
      };
    };
  };
}
