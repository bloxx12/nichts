{ pkgs, config, inputs, ... }: {
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl = {
    enable = true;
    # package = pkgs-unstable.mesa.drivers;
    driSupport = true;
    driSupport32Bit = true;
  };
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    nvidiaSettings = false;
    #package = config.boot.kernelPackages.nvidiaPackages.beta;
   package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
     version = "555.42.02";
     sha256_64bit = "sha256-k7cI3ZDlKp4mT46jMkLaIrc2YUx1lh1wj/J4SVSHWyk=";
     openSha256 = "sha256-3/eI1VsBzuZ3Y6RZmt3Q5HrzI2saPTqUNs6zPh5zy6w=";
     settingsSha256 = "";
     persistencedSha256 = "";
   };
  };
}

