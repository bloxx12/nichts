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
      inputs.lix-module.nixosModules.default
    ];
  };

  hermit = mkSystem {
    inherit withSystem;
    system = "x86_64-linux";
    modules = [
      ./vali/hermit
      ../modules
      inputs.home-manager.nixosModules.home-manager
      inputs.lix-module.nixosModules.default
      inputs.nixos-hardware.nixosModules.dell-xps-15-7590-nvidia
    ];
  };
}
