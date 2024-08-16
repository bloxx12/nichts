{
  config,
  lib,
  ...
}: let
  inherit (config.modules.other.system) username;
  cfg = config.modules.system.programs.zellij;
  inherit (lib) mkIf;
in {
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.zellij = {
        enable = true;

        enableFishIntegration = true;

        settings = {
          on_force_close = "quit";
          pane_frames = false;
          default_layout = "compact";

          ui = {
            pane_frames = {
              hide_session_name = true;
              rounded_corners = true;
            };
          };

          plugins = {
            tab-bar.path = "tab-bar";
            status-bar.path = "status-bar";
            strider.path = "strider";
            compact-bar.path = "compact-bar";
          };

          keybinds = {
            unbind = "Ctrl n";
            # resize = {
            # bind = "Ctrl n";
            # };
          };
        };
      };
    };
  };
}
