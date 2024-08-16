{lib, ...}: let
  inherit (lib) mkOption mkEnableOption;
in {
  options.modules.system.hardware = {
    nvidia = {
      enable = mkEnableOption "Nvidia Nvidia graphics drivers";
    };
    amd.enable = mkEnableOption "AMD graphics drivers";
  };
}
