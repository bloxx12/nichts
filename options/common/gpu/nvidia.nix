{config, ...}: {
  services.xserver.videoDrivers = ["nvidia"];
  hardware = {
    opengl.enable = true;
    graphics = {
      enable = true;
    };
    nvidia = {
      modesetting.enable = true;
      open = false;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      nvidiaSettings = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
