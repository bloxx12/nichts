{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.services.dunst;
  inherit (config.modules.other.system) username;

  inherit (lib) mkEnableOption mkIf;
in {
  options.modules.services.dunst.enable = mkEnableOption "dunst";

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      services.dunst = {
        enable = true;
        package = inputs.nixpkgs-wayland.packages.${pkgs.system}.dunst;
        settings = {
          global = {
            monitor = 1;
            follow = "none";
            width = 300;
            height = 100;
            origin = "top-right";
            offset = "0x10";
            scale = 0;
            notification_limit = 3;
            idle_threshold = 120;
            progress_bar = true;
            progress_bar_height = 10;
            progress_bar_frame_width = 0;
            progress_bar_min_width = 150;
            progress_bar_max_width = 300;
            indicate_hidden = "yes";
            transparency = 10;
            separator_height = 2;
            padding = 10;
            frame_width = 3;
            frame_color = "#89B4FA";
            separator_color = "frame";
            highlight = "#89DCEB";
            sort = "yes";
            font = "JetBrains Mono 12";
            line_height = 0;
            markup = "full";
            format = "<b>%s</b>%b";
            alignment = "right";
            vertical_alignment = "center";
            show_age_threshold = 60;
            ellipsize = "middle";
            ignore_newline = "no";
            stack_duplicates = true;
            hide_duplicate_count = false;
            show_indicators = "yes";
            icon_position = "left";
            min_icon_size = 0;
            max_icon_size = 32;
            sticky_history = "yes";
            history_length = 20;
            dmenu = "${pkgs.rofi-wayland}/bin/rofi";
            browser = "${pkgs.xdg-utils}/bin/xdg-open";
            always_run_script = true;
            title = "Dunst";
            class = "dunst";
            corner_radius = 10;
            ignore_dbusclose = false;
            force_xwayland = false;
            force_xinerama = false;
            mouse_left_click = "do_action, close_current";
            mouse_middle_click = "context";
            mouse_right_click = "close_all";
          };
          experimental = {per_monitor_dpi = false;};
          urgency_low = {
            background = "#1E1E2E";
            foreground = "#CDD6F4";
            timeout = 5;
          };
          urgency_normal = {
            background = "#1E1E2E";
            foreground = "#CDD6F4";
            timeout = 6;
          };
          urgency_critical = {
            background = "#1E1E2E";
            foreground = "#CDD6F4";
            frame_color = "#FAB387";
            timeout = 0;
          };
        };
      };
    };
  };
}
