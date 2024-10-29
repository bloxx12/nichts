{
  withSystem,
  inputs,
  ...
}: let
  inherit (inputs) self;
  inherit (self) lib;
  # inherit (lib.extendedLib.builders) mkSystem;
  # inherit (lib.extendedLib.modules) mkModuleTree';
  inherit (lib.lists) concatLists flatten singleton;
  inherit (lib) mkDefault nixosSystem recursiveUpdate;
  inherit (builtins) filter map toString;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (lib.strings) hasSuffix;
  # NOTE: This was inspired by raf, and I find this
  # to be quite a sane way of managing all modules in my flake.

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
            (flatten (
              concatLists [
                (singleton ./${hostname}/default.nix)
                (
                  filter (hasSuffix "module.nix") (
                    map toString (listFilesRecursive ../modules)
                  )
                )
              ]
            ))
          ];
        }
    );
in {
  flake.nixosConfigurations = {
    temperance = mkSystem {
      inherit withSystem;
      system = "x86_64-linux";
      hostname = "temperance";
    };

    hermit = mkSystem {
      inherit withSystem;
      system = "x86_64-linux";
      hostname = "hermit";
    };
  };
}
