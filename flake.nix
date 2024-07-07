{
  description = "My NixOS config flake";
  outputs = inputs @ {nixpkgs, ...}: {
    inherit (nixpkgs) lib;
    nixosConfigurations = import ./hosts {inherit inputs;};
  };
  inputs = {
    # Unstable nixpkgs baby!
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Hyprland, my main compositor
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # Plugins for hyprland
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # Plugin to get split monitor workspaces
    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland";
    };
    # Lix because fast rebuild times are cool
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.90.0-rc1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Sandboxing
    nixpak = {
      url = "github:nixpak/nixpak";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Wayland packages
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    doomemacs = {
      url = "github:doomemacs/doomemacs";
      flake = false;
    };
    neovim-flake = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    doom-emacs-config = {
      url = "github:bloxx12/doom-emacs-config";
      flake = false;
    };
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # kakoune.url = "github:mawww/kakoune";
    stylix.url = "github:danth/stylix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags.url = "github:Aylur/ags";
    schizofox = {
      url = "github:schizofox/schizofox";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpak.follows = "nixpak";
      };
    };
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    nur = {url = "github:nix-community/NUR";};
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix.url = "github:ryantm/agenix";

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
