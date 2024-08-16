{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkOption mkEnableOption;
  inherit (lib.types) str package int;
in {
  options.modules.system.hardware = {
    nvidia = {
      enable = mkEnableOption "Nvidia Nvidia graphics drivers";
    };
  };
}
