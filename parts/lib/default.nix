{inputs, ...}: let
  inherit (inputs.nixpkgs) lib;

  # Define the base library to be extended. Not only will this be an extension
  # of the nixpkgs library, but it will also be extensible the way nixpkgs lib
  # is in case the extended library
  #  1. needs to be extended internally
  #  2. needs to be extended during outside consumption
  # Additionally, .extend can be used to extend the lib with
  # custom, composed functions.
  lib0 = self: let
    callLibs = file:
      import file {
        inherit inputs;
        lib = self;
      };
  in {
    extendedLib = {
      builders = callLibs ./builders.nix;
    };

    # This makes mkSytem available *in addition* to `lib.extendedLib.builders.mkSystem`.
    # The syntax is a matter of preference, but it is good to make sure all custom attribute
    # sets (e.g., builders) are defined and taken from a separate attrset (extendedLib) to make
    # absolutely sure we *never* conflict with nixpkgs. Likewise, the function names inherited
    # here should also be different from ones available under `lib` by default, i.e., you cannot
    # re-define functions.
    inherit (self.extendedLib) builders;
    inherit (self.extendedLib.builders) mkSystem;
  };

  # This can be used with `.extend` to extend the extended library.
  extendedLib = lib.makeExtensible lib0;
in {
  # Set the `lib` argument in `perSystem`, for example:
  # ```
  # perSystem = {pkgs, lib, ...}: { ...}
  # ````
  perSystem._module.args.lib = extendedLib;

  # Prepare `lib` for external usage. This means it can be consumed
  # from inputs.<name of this flake as an input>` by other flakes.
  # `self` can also be used to access the custom lib as long as
  # `flake.lib` is set.
  flake = {
    lib = extendedLib;
    # _module.args.lib = extendedLib;
  };
}
