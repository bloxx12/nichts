{
  lib,
  inputs,
  self,
  ...
}: {
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
