{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.system.hardware;
  inherit (lib) mkIf;
in {
  config = {
    hardware = {
      graphics = {
        enable = true;
        extraPackages = with pkgs;
          mkIf cfg.amd.enable [
            mesa
            libva
            vaapiVdpa
          ];
      };
      nvidia = mkIf cfg.nvidia.enable {
        modesetting.enable = true;
        open = false;
        powerManagement = {
          enable = true;
          finegrained = false;
        };
        nvidiaSettings = false;
        package = config.boot.kernelPackages.nvidiaPackages.beta;
      };
    };
    boot.initrd.kernelModules = mkIf cfg.amd.enable ["amdgpu"];
    services.xserver.videoDrivers = mkIf cfg.nvidia.enable ["nvidia"];
  };
}
