{
  config,
  lib,
  ...
}: let
  cfg = config.modules.system.hardware.sound.pipewire;
  inherit (lib) mkIf;
in {
  config = mkIf cfg.enable {
    services.pipewire = {
      enable = true;
      audio.enable = true;

      pulse.enable = true;
      jack.enable = true;
      alsa.enable = true;
    };
  };
}
