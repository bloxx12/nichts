{
  inputs,
  lib,
  self,
  ...
}: let
  callLibs = path: import path {inherit inputs lib self;};
  sussyLib = inputs.nixpkgs.lib.extend (final: prev: {
    builders = callLibs ./builders.nix;
  });
in {
  flake = {
    lib = sussyLib;
    # raf what the hell does this do you made me set it
    _module.args.lib = sussyLib;
  };
}
