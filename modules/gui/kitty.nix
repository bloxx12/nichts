{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.system.programs.terminals.kitty;
  inherit (config.modules.other.system) username;
in {
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.kitty = {
        enable = true;
        settings = {
          mouse_hide_wait = -1;
          allow_remote_control = true;
          url_style = "curly";
          open_url_with = "default";
          confirm_os_window_close = "0";
        };
      };
    };
  };
}
