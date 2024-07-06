{
  pkgs,
  config,
  ...
}: {
  services.xserver.videoDrivers = ["nvidia"];
  hardware.graphics = {
    enable = true;
    package = pkgs.mesa.drivers;
    extraPackages = with pkgs; [
      vpl-gpu-rt
    ];
  };
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    nvidiaSettings = false;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
}
