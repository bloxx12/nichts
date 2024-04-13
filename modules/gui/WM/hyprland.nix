{ config, lib, pkgs, ... }: 

with lib;
let 
  cfg = config.modules.WM.hyprland;
  username = config.modules.other.system.username;
  monitors = config.modules.other.system.monitors;
in
{
  options.modules.WM.hyprland = {
    enable = mkEnableOption "hyprland";
    gnome-keyring = mkEnableOption "gnome-keyring";
  };


  config = mkIf cfg.enable {
    programs.xwayland.enable = true;
    programs.hyprland = {
      	enable = true;
    };
  services.gnome.gnome-keyring.enable = mkDefault cfg.gnome-keyring;
  systemd.user.services.polkit-gnome-authentication-agent-1 = mkIf cfg.gnome-keyring {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
    };
  };

  home-manager.users.${username} = {
    home.packages = with pkgs; [ 
      rofi 
      waybar 
      hyprpaper
      hyprlock
      hyprland
      hyprshade
      lxqt.lxqt-openssh-askpass

      dunst 
      # wireplumber 
      xwayland
      pciutils # lspci is needed by hyprland
      dunst 
      swww
      flameshot
      bluetuith
      brightnessctl
      # needed for wayland copy / paste support in neovim
      wl-clipboard
    ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;
    settings = {
      exec-once = [
        "waybar"
      ] ++ (if cfg.gnome-keyring then ["${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"]
        else []);
      monitor = map (
        m: "${m.device},${builtins.toString m.resolution.x}x${builtins.toString m.resolution.y}@${builtins.toString m.refresh_rate},${builtins.toString m.position.x}x${builtins.toString m.position.y},${builtins.toString m.scale},transform,${builtins.toString m.transform}"
      ) monitors; #TODO: default value
      input = {
        kb_layout = "us";
        natural_scroll = true;
        sensitivity = 0;
      };
      general = {
        gaps_in = 2;
        gaps_out = 1;
        border_size = 1;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };
      decoration.rounding = 5;
      misc.disable_hyprland_logo = true;
      animations = {
          enabled = true;
          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = ["myBezier, 0.05, 0.9, 0.1, 1.05"];

          animation = [
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
            "windows, 1, 7, myBezier"
          ];
      };
      gestures.workspace_swipe = true;
      debug.enable_stdout_logs = true;
      bind = [
        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        "SUPER, RETURN, exec, alacritty"
        "SUPER SHIFT, RETURN, exec, rofi -show drun"
        "SUPER SHIFT, Q, killactive,"
        "SUPER, M, exit, "
        "SUPER, B, exec, firefox"
        "SUPER, f, fullscreen"
        "SUPER, E, exec, nautilus --new-window "
        "SUPER, V, togglefloating, "
        "SUPER, P, pseudo, # dwindle"
        "SUPER, S, togglesplit, # dwindle"
        "SUPER, C, exec, /home/vali/.config/wallpaper/colorscheme-setter"
        ",PRINT, exec, flameshot"

        
        # Move focus with mainMod + arrow keys"
        "SUPER, h, movefocus, l"
        "SUPER, l, movefocus, r"
        "SUPER, k, movefocus, u"
        "SUPER, j, movefocus, d"
        
        # move window to next / previous workspace"
        "SUPER CTRL, h, movetoworkspace, -1"
        "SUPER CTRL, l, movetoworkspace, +1"
        
        # move to next / previous workspace"
        "SUPER CTRL, h, workspace, -1"
        "SUPER CTRL, l, workspace, +1"
        
        
        # Switch workspaces with mainMod + [0-9]"
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"
        
        # Move active window to a workspace with mainMod + SHIFT + [0-9]"
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"
        "SUPER SHIFT, 0, movetoworkspace, 10"
        
        # Scroll through existing workspaces with mainMod + scroll"
        "SUPER, mouse_down, workspace, e+1"
        "SUPER, mouse_up, workspace, e-1"
        
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "SUPER, mouse:272, movewindow"
        # "bindm = SUPER, mouse:273, resizewindow"
      ];
      binde = [
        ",XF86MonBrightnessUp, exec, brightnessctl set 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl set 10%-"
        # Example volume button that allows press and hold, volume limited to 150%"
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
        # Example volume button that will activate even while an input inhibitor is active"
        ",XF86AudioLowerVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, $ wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];
    };
  };
  };
  };
}
