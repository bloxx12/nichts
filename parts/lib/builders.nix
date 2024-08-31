{inputs, ...}: let
  inherit (inputs) self nixpkgs;
  inherit (nixpkgs) lib;
  inherit (lib) mkDefault nixosSystem recursiveUpdate singleton;
  inherit (builtins) concatLists;
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
            # We need a singleton here since we concatenate lists, and a singleton
            # generates a list with a single element.
            (singleton {
              nixpkgs.hostPlatform = mkDefault args.system;
            })

            # We pass our modules from the arguments
            (args.modules or [])
          ];
        }
    );
}
