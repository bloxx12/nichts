{
  inputs,
  withSystem,
  ...
}: let
  inherit (inputs) self;
  inherit (inputs.nixpkgs) lib;

  mkSystem = {
    withSystem,
    system,
    ...
  } @ args:
    withSystem system (
      {
        inputs',
        self',
        ...
      }:
        lib.nixosSystem {
          inherit system;
          specialArgs =
            lib.recursiveUpdate
            {
              inherit lib;
              inherit inputs inputs';
              inherit self self';
              inherit system;
            }
            (args.specialArgs or {});
          inherit (args) modules;
        }
    );
in {
  temperance = mkSystem {
    inherit withSystem;
    system = "x86_64-linux";
    modules = [
      ./vali/temperance
      ../modules
      inputs.home-manager.nixosModules.home-manager
      inputs.agenix.nixosModules.default
      inputs.lix-module.nixosModules.default
    ];
  };

  # temperance =
  #   lib.nixosSystem rec {
  #     system = "x86_64-linux";
  #     specialArgs = {
  #       inherit lib;
  #       inherit
  #         inputs
  #         self
  #         system
  #         ;
  #     };
  #   });
  hermit = lib.nixosSystem rec {
    system = "x86_64-linux";
    specialArgs = {inherit lib inputs self system;};
    modules = [
      ./vali/hermit
      ../modules
      inputs.home-manager.nixosModules.home-manager
      inputs.agenix.nixosModules.default
      inputs.lix-module.nixosModules.default
      inputs.nixos-hardware.nixosModules.dell-xps-15-7590-nvidia
    ];
  };
}
