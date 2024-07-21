{
  config,
  lib,
  ...
}: let
  cfg = config.modules.usrEnv.programs.media.beets;
  inherit (config.modules.other.system) username;
  inherit (config.modules.services.mpd) musicDirectory;
  inherit (lib) mkIf;
in {
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.beets = {
        enable = true;

        settings = {
          ui.color = true;
          directory = musicDirectory;
          library = "${musicDirectory}/musiclibrary.db";

          clutter = [
            "Thumbs.DB"
            ".DS_Store"
            ".directory"
          ];

          plugins = [
            # "acousticbrainz" # DEPRECATED
            "mpdupdate"
            "lyrics"
            "thumbnails"
            "fetchart"
            "embedart"
            "chroma"
            "fromfilename"
            "lastgenre"
            #"absubmit" # DEPRECATED
            "duplicates"
            "edit"
            #"mbcollection" # not set up yet
            # "mbsync"
            "replaygain"
            "scrub"
          ];

          import = {
            move = true;
            timid = true;
            detail = true;
            bell = true;
            write = true;
          };

          mpd = {
            host = "localhost";
            port = 6600;
          };

          lyrics = {
            auto = true;
          };

          thumbnails.auto = true;
          fetchart.auto = true;

          embedart = {
            auto = true;
            remove_art_file = true;
          };

          acousticbrainz.auto = true;
          chroma.auto = true;
          replaygain.backend = "gstreamer";
        };
      };
    };
  };
}
