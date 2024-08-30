{inputs, ...}: let
  callLibs = path:
    import path {
      inherit inputs;
      inherit lib;
    };
  lib = inputs.nixpkgs.lib.extend {
    builders = callLibs ./builders.nix;
  };
in {
  perSystem = {
    _module.args.lib = lib;
  };
  flake = {
    inherit lib;
    # raf what the hell does this do you made me set it
    _module.args.lib = lib;
  };
}
