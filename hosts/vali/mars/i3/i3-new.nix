{pkgs, lib, config, ... }:
with lib; let
  cfg = config.myOptions.programs.i3;
  username = config.myOptions.other.system.username;
  mod = "Mod4";
in {
  options.myOptions.programs.i3.enable = mkEnableOption "i3";

  config = mkIf cfg.enable {
      services.xserver = {
          enable = true;
          xkb.layout =  "de";
      };
      xsession.windowManager.i3 = {
          enable = true;
          config = {
              modifier = mod;
              terminal = "alacritty";
              fonts ={
                 names = [ "JetBrains Mono" "pango:monospace"];
                 size = 12;
                 style = "Bold Semi-Condensed";
                };
              keybindings = lib.mkOptionDefault {
                  # Run stuff
                  "${mod}+d" = "exec --no-startup-id ${pkgs.dmenu}/bin/dmenu_run";
                  "${mod}+Return" = "exec --no-startup-id alacritty";
                  "${mod}+Shift+q" = "kill";
                  # Focus
                  "${mod}+h" = "focus left";
                  "${mod}+j" = "focus down";
                  "${mod}+k" = "focus up";
                  "${mod}+l" = "focus right";
                  # Move
                  "${mod}+Shift+h" = "move left";
                  "${mod}+Shift+j" = "move down";
                  "${mod}+Shift+k" = "move up";
                  "${mod}+Shift+l" = "move right";
                  "XF86RaiseVolume" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ && $refresh_i3status";
                  # Toggle stuff
                  "${mod}+f" = "fullscreen toggle";
              };
              window = {
                  titlebar = false;
                  border = 3;
                  hideEdgeBorders = true;
              };
              floating = {
                  titlebar = false;
              };
              bars = [
                  {
                  position = "bottom";
                  statusCommand = "${pkgs.i3status}/bin/i3status";
                  }
              ];
              startup ={
                  command = 
                      "xrandr --output HDMI-1 --rotate normal --output DP-2 --rotate normal --left-of HDMI-1 --output HDMI-0 --right-of HDMI-1";
                      #"dex --autostart --environment i3";
                      #"nm-applet";
                      #"keepassxc";
              };
          };
      };
  };
}

