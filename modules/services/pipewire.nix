{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.system.sound;
in {
  config = mkIf cfg.enable {
    services.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      alsa.enable = true; # TODO Do I need this?
      pulse.enable = true;
    };
    security.rtkit.enable = true;
  };
}
