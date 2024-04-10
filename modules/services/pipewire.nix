{ config, lib, ... }:
in {
  options.myOptions.services.enable = mkEnableOption "pipewire";

  config = mkIf config.myOptions.services.pipewire.enable {
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
