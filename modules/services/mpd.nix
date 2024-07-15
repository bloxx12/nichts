{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.services.mpd;
  inherit (config.modules.other.system) username;

  inherit (lib) mkEnableOption mkIf mkOption;
  inherit (lib.types) str;
in {
  options.modules.services.mpd = {
    enable = mkEnableOption "mpd";
    musicDirectory = mkOption {
      description = "music directory for mpd";
      type = str;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [mpc-cli];
    systemd.services.mpd.environment = {
      # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
      XDG_RUNTIME_DIR = "/run/user/1000";
    };
    services.mpd = {
      enable = true;
      inherit (cfg) musicDirectory;
      user = username;
      extraConfig = ''
        user "${username}"
        playlist_directory "${cfg.musicDirectory}/.playlists"
        restore_paused "yes"

        volume_normalization "yes"

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
    home-manager.users.${username} = {
      services = {
        mpd-mpris = {
          enable = true;
          mpd = {
            host = "127.0.0.1";
            network = "unix";
            port = 6600;
            useLocal = true;
          };
        };

        playerctld = {
          enable = true;
        };
      };
    };
  };
}
