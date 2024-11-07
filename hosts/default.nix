inputs: let
  inherit (inputs) self;
  inherit (inputs.nixpkgs) lib;
  inherit (lib.lists) concatLists flatten singleton;
  inherit (lib) mkDefault nixosSystem recursiveUpdate;
  inherit (builtins) filter map toString;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (lib.strings) hasSuffix;
  # NOTE: This was inspired by raf, and I find this
  # to be quite a sane way of managing all modules in my flake.

  mkSystem = {
    system,
    hostname,
    ...
  } @ args:
    nixosSystem {
      inherit system;
      specialArgs =
        recursiveUpdate
        {
          inherit lib;
          inherit inputs;
          inherit self;
        }
        (args.specialArgs or {});
      modules = concatLists [
        # This is used to pre-emptively set the hostPlatform for nixpkgs.
        # Also, we set the system hostname here.
        [
          self.nixosModules.user
        ]
        (singleton {
          networking.hostName = hostname;
          #thanks raf
          nixpkgs.hostPlatform = system;
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
    };
in {
  temperance = mkSystem {
    system = "x86_64-linux";
    hostname = "temperance";
  };

  hermit = mkSystem {
    system = "x86_64-linux";
    hostname = "hermit";
  };
}
