{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  test = inputs.wrapper-manager.lib.build {
    inherit pkgs;
    modules = [
      {
        wrappers = {
          test = {
            basePackage = pkgs.hello;
          };
        };
      }
    ];
  };
in {
  environment.systemPackages = [test];
}
