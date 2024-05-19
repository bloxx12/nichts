{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.programs.kitty;
  username = config.modules.other.system.username;
in {
  options.modules.programs.kitty.enable = mkEnableOption "kitty";

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.kitty = {
        enable = true;
        settings = {
          # font_size = "13.0";
          mouse_hide_wait = -1;
          allow_remote_control = true;
          url_style = "curly";
          open_url_with = "default";
          #background_opacity = "0.9";
          confirm_os_window_close = "0";
        };

      };
    };
  };

}
