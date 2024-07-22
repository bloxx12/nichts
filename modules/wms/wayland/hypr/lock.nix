{
  config,
  inputs,
  inputs',
  lib,
  pkgs,
  ...
}: let
  cfg = config.myOptions.programs.hypr.lock;
  inherit (config.myOptions.other.system) username;

  inherit (lib) mkEnableOption mkIf mkOption;
  inherit (lib.types) attrs;

  text_color = "rgba(eae0e4FF)";
in {
  options.myOptions.programs.hypr.lock = {
    enable = mkEnableOption "hiper zamek";
    extraSettings = mkOption {
      type = attrs;
      description = "extra per host hyprlock settings";
      default = {};
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      imports = [inputs.hyprlock.homeManagerModules.default];

      programs.hyprlock = {
        enable = true;
        package = inputs'.hyprlock.packages.hyprlock;
        general = {
          grace = 2;
        };
        backgrounds = [
          {
            color = "rgba(120f1177)";
            path = "screenshot";
            blur_size = 5;
            blur_passes = 4;
          }
        ];

        input-fields = [
          {
            size = {
              width = 600;
              height = 50;
            };
            outline_thickness = 3;
            dots_size = 0.1;
            dots_spacing = 0.3;
            outer_color = "rgba(9a8d9555)";
            inner_color = "rgba(120f1111)";
            font_color = "rgba(d1c2cbff)";
            fade_on_empty = true;
            position = {
              x = 0;
              y = 20;
            };
            halign = "center";
            valign = "center";
          }
        ];

        labels = [
          {
            # clock
            text = "$TIME";
            color = text_color;
            font_size = 65;
            position = {
              x = 0;
              y = 300;
            };
            halign = "center";
            valign = "center";
          }
          {
            # battery
            text = "cmd[update:1000] echo \"$(cat /sys/class/power_supply/BAT0/capacity)%\"";
            color = text_color;
            font_size = 30;
            position = {
              x = 0;
              y = 200;
            };
            halign = "center";
            valign = "center";
          }
        ];
      };
    };
  };
}
