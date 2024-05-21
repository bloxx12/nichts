{
  description = "My NixOS config flake";
  outputs = inputs@{ self, nixpkgs, ... }: {
    inherit (nixpkgs) lib;
    nixosConfigurations = import ./hosts { inherit inputs; };
  };
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland.url =
      # "git+https://github.com/hyprwm/Hyprland?ref=refs/tags/v0.40.0&submodules=1";
      "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    nixpak = {
      url = "github:nixpak/nixpak";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland";
    };
    doomemacs = {
      url = "github:doomemacs/doomemacs";
      flake = false;
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
    schizofox = {
      url = "github:schizofox/schizofox";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpak.follows = "nixpak";
      };
    };
    spicetify-nix.url = "github:the-argus/spicetify-nix";
    nur = { url = "github:nix-community/NUR"; };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = "github:ryantm/agenix";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    waybar.url = "github:Alexays/Waybar";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
}
