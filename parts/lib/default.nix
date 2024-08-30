{inputs, ...}: let
  callLibs = path:
    import path {
      inherit inputs;
      lib = extendedLib;
    };
  extendedLib = inputs.nixpkgs.lib.extend {
    builders = callLibs ./builders.nix;
  };
in {
  # perSystem = {
  #   _module.args.lib = lib;
  # };
  flake = {
    lib = extendedLib;
    _module.args.lib = extendedLib;
  };
}
