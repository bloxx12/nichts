{
  description = "My NixOS config flake";
  outputs = inputs: let
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    user = import ./modules/user {inherit inputs pkgs;};
  in {
    nixosConfigurations = import ./hosts inputs;

    devShells.x86_64-linux.default = pkgs.callPackage ./shell.nix {};

    formatter.x86_64-linux = pkgs.alejandra;
    packages.x86_64-linux = user.packages;

    apps.x86_64-linux = {
      default = {
        type = "app";
        program = "${user.packages.fish}/bin/fish";
      };
      helix = {
        type = "app";
        program = "${user.packages.helix}/bin/hx";
      };
    };
    nixosModules = {
      user = user.module;
      # shell = import ./modules/shell {inherit pkgs;};
    };
  };
  inputs = {
    # Unstable nixpkgs baby!
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Lix, a faster nix fork.
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland, my main compositor
    hyprland.url = "github:hyprwm/Hyprland";

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

    hyprsplit = {
      url = "github:shezdy/hyprsplit";
      inputs.hyprland.follows = "hyprland";
    };

    impermanence.url = "github:nix-community/impermanence";

    # Helix my beloved
    helix.url = "github:helix-editor/helix";

    # I use schizofox as my personal browser. This is because I am schizophrenic.
    schizofox = {
      url = "github:schizofox/schizofox";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:gerg-l/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
