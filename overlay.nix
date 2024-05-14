{ inputs, outputs, ... }:

let
  add_nur = self: super: {
    # nur-no-pkgs = import inputs.nur-no-pkgs { pkgs = inputs.nixpkgs.legacyPackages.${profile-config.system}; nurpkgs = inputs.nixpkgs.legacyPackages.${profile-config.system}; };
    nur = import inputs.nur {
      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      }; # .legacyPackages.${profile-config.system};
      nurpkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      }; # .legacyPackages.${profile-config.system};
    };
  };
in { nixpkgs.overlays = [ add_nur ]; }
