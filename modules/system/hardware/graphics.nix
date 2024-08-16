{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.system.hardware;
  inherit (cfg) amd nvidia;
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
            vaapiVdpau
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
        package = config.boot.kernelPackges.nvidiaPackages.beta;
      };
    };
    boot.initrd.kernelModules = mkIf amd.enable ["amdgpu"];
    services.xserver.videoDrivers = mkIf nvidia.enable ["nvidia"];
  };
}
