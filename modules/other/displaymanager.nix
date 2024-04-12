{pkgs, lib, config, ...}:
with lib; let 
    cfg = config.myOptions.programs.displaymanager;
in {
    options.myOptions.programs.displaymanager.enable = mkEnableOption "displaymanager";

    config = mkIf cfg.enable {
        services.xserver.displayManager = {
          gdm.enable = true;
          defaultSession = "none+i3";
        }
      }
}
