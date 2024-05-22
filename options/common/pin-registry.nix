{
  inputs,
  lib,
  ...
}: {
  nix.registry = lib.mapAttrs (_: v: {flake = v;}) inputs;
}
