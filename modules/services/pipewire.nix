{ config, lib, ... }:
with lib; let
  cfg = config.myOptions.services.pipewire;
in {
  options.myOptions.services.pipewire.enable = mkEnableOption "pipewire";

  config = mkIf cfg.enable {
    hardware.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    security.rtkit.enable = true;
  };
}
