{
  withSystem,
  inputs,
  ...
}: let
  inherit (inputs.self) lib;
  inherit (lib.extendedLib.builders) mkSystem;
  inherit (lib.extendedLib.modules) mkModuleTree';
  inherit (lib.lists) concatLists flatten singleton;

  # NOTE: This was inspired by raf, and I find this
  # to be quite a sane way of managing all modules in my flake.

  mkModulesFor = hostname:
    flatten (
      concatLists [
        # Derive host specific module path from the first argument of the
        # function. Should be a string, obviously.
        (singleton ./${hostname}/default.nix)

        # Recursively import all module trees (i.e. directories with a `module.nix`)
        # for given moduleTree directories
        (mkModuleTree' {path = ../modules;})
      ]
    );
in {
  flake.nixosConfigurations = {
    temperance = mkSystem {
      inherit withSystem;
      system = "x86_64-linux";

      hostname = "temperance";
      modules = mkModulesFor "temperance";
    };

    hermit = mkSystem {
      inherit withSystem;
      system = "x86_64-linux";

      hostname = "hermit";
      modules = mkModulesFor "hermit";
    };
  };
}
