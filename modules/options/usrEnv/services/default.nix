{
  config,
  lib,
  ...
}: let
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib) types;
  inherit (config.meta.mainUser) username;
in {
  options.modules.usrEnv.services = {
    locate.enable = mkEnableOption "Locate service";
    media = {
      mpd = {
        enable = mkEnableOption "mpd service";
        musicDirectory = mkOption {
          description = "music directory for mpd";
          type = types.str;
          default = "/home/${username}/cloud/media/Music";
        };
      };
    };
  };
}
