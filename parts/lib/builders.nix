{
  inputs,
  lib,
  ...
}: let
  inherit (inputs) self;
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
