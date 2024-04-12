{ config, lib, pkgs, ...}:
{
  services.xserver.videoDrivers = [ "nvidia" ];
  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    WLR_NO_HARDWARE_CURSORS = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
  environment.systemPackages = with pkgs; [
      vulkan-loader
      vulkan-validation-layers
      vulkan-tools
  ];
  hardware = {
        nvidia = {
            open = true;
            nvidiaSettings = false;
            powerManagement.enable = true;
            powerManagement.finegrained = false;
            modesetting.enable = true;
            package = config.boot.kernelPackages.nvidiaPackages.beta;
        };
  };
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [ nvidia-vaapi-driver ];
  };
}

