{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkDefault mkIf;
  inherit (config.modules.system.video) nvidia amd;
in {
  hardware = {
    cpu.intel.updateMicrocode = mkDefault config.hardware.enableRedistributableFirmware;
    graphics.extraPackages = with pkgs; [
      intel-vaapi-driver
      intel-media-driver
    ];
  };
}
