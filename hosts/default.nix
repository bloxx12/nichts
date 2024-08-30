{
  inputs,
  lib,
  withSystem,
  ...
}: let
  # inherit (inputs) self;
  # inherit (inputs.nixpkgs) lib;
  inherit (lib.builders) mkSystem;
  # mkSystem = {
  #   withSystem,
  #   system,
  #   ...
  # } @ args:
  #   withSystem system (
  #     {
  #       inputs',
  #       self',
  #       ...
  #     }:
  #       lib.nixosSystem {
  #         inherit system;
  #         specialArgs =
  #           lib.recursiveUpdate
  #           {
  #             inherit lib;
  #             inherit inputs inputs';
  #             inherit self self';
  #           }
  #           (args.specialArgs or {});
  #         inherit (args) modules;
  #       }
  #   );
in {
  flake.nixosConfigurations = {
    temperance = mkSystem {
      inherit withSystem;
      system = "x86_64-linux";
      modules = [
        ./vali/temperance
        ../modules
      ];
    };

    hermit = mkSystem {
      inherit withSystem;
      system = "x86_64-linux";
      modules = [
        ./vali/hermit
        ../modules
      ];
    };
  };
}
