{
  inputs,
  lib,
  ...
}: let
  inherit (inputs) self;
  inherit (lib) mkDefault nixosSystem recursiveUpdate;
  inherit (lib.lists) singleton concatLists;

  mkSystem = {
    withSystem,
    system,
    hostname,
    ...
  } @ args:
    withSystem system (
      {
        inputs',
        self',
        ...
      }:
        nixosSystem {
          inherit system;
          specialArgs =
            recursiveUpdate
            {
              inherit lib;
              inherit inputs inputs';
              inherit self self';
            }
            (args.specialArgs or {});
          modules = concatLists [
            # This is used to pre-emptively set the hostPlatform for nixpkgs.
            # Also, we set the system hostname here.
            (singleton {
              networking.hostName = args.hostname;
              nixpkgs.hostPlatform = mkDefault args.system;
            })

            # We pass our modules from the arguments
            (args.modules or [])
          ];
        }
    );
in {
  inherit mkSystem;
}
