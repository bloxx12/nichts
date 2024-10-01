{
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.usrEnv.desktops.hyprland;
  inherit (config.modules.other.system) username;
  inherit (builtins) map genList toString;
in {
  home-manager.users.${username}.wayland.windowManager.hyprland.settings = {
    # Keybinds
    bind =
      # workspaces
      # split-workspace is because of the split-workspace plugin
      map (
        i: let
          mod = a: b: a - (b * (a / b));
          key = toString (mod i 10);
          workspace = toString i;
        in "$mainMod, ${key}, split-workspace, ${workspace}"
      ) (genList (i: i + 1) 10)
      # split-movetoworkspacesilent
      ++ map (
        i: let
          mod = a: b: a - (b * (a / b));
          key = toString (mod i 10);
          workspace = toString i;
        in "$mainMod SHIFT, ${key}, split-movetoworkspacesilent, ${workspace}"
      ) (genList (i: i + 1) 10)
      ++ map (
        i: let
          mod = a: b: a - (b * (a / b));
          key = toString (mod i 10);
          index = toString i;
        in "$mainMod CONTROL, ${key}, hy3:focustab, index, ${index}"
      ) (genList (i: i + 1) 10)
      ++ [
        "$mainMod, RETURN, exec, ${pkgs.foot}/bin/foot"
        "$mainMod, Q, hy3:killactive"
        "$mainMod, F, fullscreen, 0"
        "$mainMod, D, exec, ${pkgs.procps}/bin/pkill fuzzel || ${pkgs.fuzzel}/bin/fuzzel"
        "$mainMod, SPACE, togglefloating, active"

        # Move Windows
        "$mainMod SHIFT, H, hy3:movewindow, l, once"
        "$mainMod SHIFT, J, hy3:movewindow, d, once"
        "$mainMod SHIFT, K, hy3:movewindow, u, once"
        "$mainMod SHIFT, L, hy3:movewindow, r, once"

        # Screenshotting
        "$mainMod, S, exec, ${pkgs.grimblast}/bin/grimblast copy area"

        # File manager
        "$mainMod, E, exec, ${pkgs.xfce.thunar}/bin/thunar"

        # Toggle the three different special workspaces.
        "$mainMod, N, togglespecialworkspace, nixos"
        "$mainMod, X, togglespecialworkspace, keepassxc"
        "$mainMod, V, togglespecialworkspace, audio"

        # Reload hyprland
        "$mainMod, R, exec, ${cfg.package}/bin/hyprctl reload"

        # Restart waybar
        "$mainMod CONTROL, B, exec, ${pkgs.procps}/bin/pkill waybar || ${pkgs.waybar}/bin/waybar"

        # hy3 group settings
        "$mainMod, Z, hy3:makegroup, h"
        "$mainMod SHIFT, Z, hy3:makegroup, v"
        "$mainMod, U, hy3:makegroup, tab"
        "$mainMod, A, hy3:changefocus, raise"
        "$mainMod SHIFT, A, hy3:changefocus, lower"
        "$mainMod, C, hy3:changegroup, opposite"
      ];

    binde = [
      # window focus
      "$mainMod, H, hy3:movefocus, l"
      "$mainMod, J, hy3:movefocus, d"
      "$mainMod, K, hy3:movefocus, u"
      "$mainMod, L, hy3:movefocus, r"
    ];

    # Media controls
    bindl = let
      play-pause = "${pkgs.playerctl}/bin/playerctl play-pause";
      stop = "${pkgs.playerctl}/bin/playerctl stop";
      prev = "${pkgs.playerctl}/bin/playerctl previous";
      next = "${pkgs.playerctl}/bin/playerctl next";
      toggle-mute = "${pkgs.pamixer}/bin/pamixer --toggle-mute";
    in [
      ", XF86AudioMedia, exec, ${play-pause}"
      ", XF86AudioPlay,  exec, ${play-pause}"
      ", XF86AudioStop,  exec, ${stop}"
      ", XF86AudioPrev,  exec, ${prev}"
      ", XF86AudioNext,  exec, ${next}"
      ", XF86AudioMute,  exec, ${toggle-mute}"
    ];

    # locked + repeat
    bindle = let
      volume_up = "${pkgs.pamixer}/bin/pamixer -ui 5";
      volume_down = "${pkgs.pamixer}/bin/pamixer -ud 5";
      brightness_up = "${pkgs.brightnessctl}/bin/brightnessctl set +10%";
      brightness_down = "${pkgs.brightnessctl}/bin/brightnessctl set 10%-";
    in [
      ", XF86AudioRaiseVolume, exec, ${volume_up}"
      ", XF86AudioLowerVolume, exec, ${volume_down}"
      ", XF86MonBrightnessUp, exec, ${brightness_up}"
      ", XF86MonBrightnessDown, exec, ${brightness_down}"
    ];

    # Mouse settings
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    # Some more movement-related settings
    binds = {
      pass_mouse_when_bound = false;
      movefocus_cycles_fullscreen = false;
    };
  };
}
