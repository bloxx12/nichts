{
  inputs',
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.modules.usrEnv;
  inherit (lib.options) mkOption;
  inherit (lib.types) bool enum package;
in {
  options.modules.usrEnv = {
    desktop = mkOption {
      type = enum ["none" "Hyprland" "awesomewm" "i3"];
      default = "none";
      description = ''
        The desktop environment to be used.
      '';
    };

    desktops = {
      hyprland = {
        enable = mkOption {
          type = bool;
          default = cfg.desktop == "Hyprland";
          description = ''
            Whether to enable Hyprland wayland compositor.

            Will be enabled automatically when `modules.usrEnv.desktop`
            is set to "Hyprland".

          '';
        };

        package = mkOption {
          type = package;
          default = pkgs.hyprland;
          description = ''
            The Hyprland package to be used.
          '';
        };
        portalPackage = mkOption {
          type = package;
          default = pkgs.xdg-desktop-portal-hyprland;
          description = "The hyprland portal package";
        };
      };

      awesomwm.enable = mkOption {
        type = bool;
        default = cfg.desktop == "awesomewm";
        description = ''
          Whether to enable Awesome window manager

          Will be enabled automatically when `modules.usrEnv.desktop`
          is set to "awesomewm".
        '';
      };

      i3 = {
        enable = mkOption {
          type = bool;
          default = cfg.desktop == "i3";
          description = ''
            Whether to enable i3 window manager

            Will be enabled automatically when `modules.usrEnv.desktop`
            is set to "i3".
          '';
        };

        package = mkOption {
          type = package;
          default = pkgs.i3;
          description = ''
            The i3 package to be used.
          '';
        };
      };
    };
  };
}
