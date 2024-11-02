{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.usrEnv.services.media.mpd;
  inherit (config.modules.other.system) username;
  inherit (lib) mkIf;
in {
  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.mpc-cli];
    systemd.services.mpd.environment = {
      # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
      XDG_RUNTIME_DIR = "/run/user/1000";
    };
    services.mpd = {
      enable = true;
      inherit (cfg) musicDirectory;
      user = username;
      startWhenNeeded = true;
      extraConfig = ''
        restore_paused "yes"
        auto_update "yes"
        playlist_directory "${cfg.musicDirectory}/.playlists"

          audio_output {
              type "pipewire"
              name "PipeWire Sound Server"
          }

           audio_output {
              type   "fifo"
              name   "FIFO"
              path   "/tmp/mpd.fifo"
              format "44100:16:2"
          }
      '';
    };
  };
}
