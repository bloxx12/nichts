{inputs, ...}: let
  inherit (inputs) self nixpkgs;
  inherit (nixpkgs) lib;
in {
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
}
