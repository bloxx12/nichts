{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.services.pipewire;
in {
  options.modules.services.pipewire.enable = mkEnableOption "pipewire";

  config = mkIf cfg.enable {
    hardware.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };
    security.rtkit.enable = true;
  };
}
