{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.modules.system.hardware) nvidia amd;
  inherit (lib) mkIf;
in {
  config = {
    hardware = {
      graphics = {
        enable = true;
        extraPackages = with pkgs;
          mkIf amd.enable [
            mesa
            libva
            vaapiVdpa
          ];
      };
    };
    nvidia = mkIf nvidia.enable {
      modesetting.enable = true;
      open = false;
      powerManagement = {
        enable = true;
        finegrained = false;
        nvidiaSettings = false;
        package = config.boot.kernelPackages.nvidiaPackages.beta;
      };
    };
    boot.initrd.kernelModules = mkIf amd.enable ["amdgpu"];
    services.xserver.videoDrivers = mkIf nvidia.enable ["nvidia"];
  };
}
