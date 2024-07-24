{lib, ...}: let
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib) types;
in {
  options.modules.usrEnv.services = {
    locate.enable = mkEnableOption "Locate service";
    wpaperd.enable = mkEnableOption "Wpaperd wallpaper daemon";
    media = {
      mpd = {
        enable = mkEnableOption "mpd service";
        musicDirectory = mkOption {
          description = "music directory for mpd";
          type = types.str;
        };
      };
    };
  };
}
