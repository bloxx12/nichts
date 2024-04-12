{ config, inputs, lib, pkgs, ... }:

with lib; let

    cfg = config.myOptions.programs.hypr.land;
    username = config.myOptions.other.system.username;
    hmCfg = config.home-manager.users.${username};
                        
    smwPresent = elem inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces cfg.extraPlugins;

    inherit (inputs.nixpkgs-wayland.packages.${pkgs.system}) foot wl-clipboard swww wlsunset;
    inherit (inputs.anyrun.packages.${pkgs.system}) anyrun;
    inherit (inputs.hyprland.packages.${pkgs.system}) hyprland;
    inherit (inputs.hyprlock.packages.${pkgs.system}) hyprlock;
in {
    options.myOptions.programs.hypr.land = {
        enable = mkEnableOption "huperland";
        startupSound = mkOption {
            type = with types; nullOr path;
            description = "sound to play on hyprland startup";
            default = null;
        };
        tearing = mkOption {
            type = types.bool;
            description = "enable tearing";
            default = false;
        };
        extraSettings = mkOption {
            type = types.attrs;
            description = "extra per host hyprland settings";
            default = {};
        };
        extraPlugins = mkOption {
            type = with types; listOf package;
            description = "extra per host hyprland plugins";
            default = [];
        };
    };

    disabledModules = [ "programs/hyprland.nix" ];

    config = mkIf cfg.enable {
        nix.settings = {
            substituters = [ "https://hyprland.cachix.org" ];
            trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
        };

        environment.sessionVariables = {
            XDG_CURRENT_DESKTOP = "Hyprland";
            XDG_SESSION_TYPE = "wayland";
            XDG_SESSION_DESKTOP = "Hyprland";

            SDL_VIDEODRIVER = "wayland";

            _JAVA_AWT_WM_NONEREPARENTING = "1";
            
            CLUTTER_BACKEND = "wayland";
            
            GDK_BACKEND = "wayland";

            QT_QPA_PLATFORM = "wayland";

            LIBSEAT_BACKEND = "logind";
        };

        xdg.portal = {
            enable = true;
            extraPortals = [
                pkgs.xdg-desktop-portal-gtk
                inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
            ];
            # TODO look into and make use of this
            config.common.default = "*";
        };

        home-manager.users.${username} = {

            xdg.dataFile = mkIf (cfg.startupSound != null) { "hypr/startup_sound".source = cfg.startupSound; };

            wayland.windowManager.hyprland = {
                enable = true;
                package = inputs.hyprland.packages.${pkgs.system}.hyprland;
                #portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
                plugins = [] ++ cfg.extraPlugins;
                # TODO make these work with the config below (infinite recursion)
                # and make this file stop hanging my neovim every 2 seconds
                # and figure out why it triggers E79 every single time I edit something
                extraConfig = ''
                    bind=$mainMod, W, exec, schizofox
                    ${if (cfg.startupSound != null) then "exec-once=${pkgs.mpv}/bin/mpv --no-video --volume=100 ${hmCfg.xdg.dataHome}/hypr/startup_sound" else ""}
                '';
                settings = {
                    "$mainMod" = "SUPER";

                    monitor = [
                        # second monitor
                        "HDMI-A-1, 1920@1080, 0x0, 1"
                    ];

                    workspace = [
                        # second monitor
                        "1, monitor:HDMI-A-1, default:true"
                        "2, monitor:HDMI-A-1"
                        "3, monitor:HDMI-A-1"
                        "4, monitor:HDMI-A-1"
                        "5, monitor:HDMI-A-1"
                        "6, monitor:HDMI-A-1"
                        "7, monitor:HDMI-A-1"
                        "8, monitor:HDMI-A-1"
                        "9, monitor:HDMI-A-1"
                        "10, monitor:HDMI-A-1"

                        # scratchpads
                        "special:btop, decorate:false"
                        "special:pipewire, decorate:false"
                        "special:nixos, decorate:false"
                        (mkIf config.services.asusd.enable
                            "special:rog, decorate:false")
                        "special:keepassxc, decorate:false"
                    ];

                    input = {
                        kb_layout = "de";
                        kb_variant = "";
                        kb_model = "";
                        kb_options = "";
                        kb_rules = "";

                        follow_mouse = true;
                        touchpad = {
                            disable_while_typing = false;
                        };

                        repeat_rate = 50;
                        repeat_delay = 250;
                        touchdevice = {
                            output = "eDP-1";
                        };

                        tablet = {
                            output = "HDMI-A-1";
                        };
                    };

                    general = {
                        sensitivity = 1.0;

                        gaps_in = 5;
                        gaps_out = 5;
                        border_size = 2;

                        apply_sens_to_raw = 0;

                        #no_border_on_floating = true;
                        allow_tearing = mkIf cfg.tearing true;

                        "col.active_border" = "0xFFF5C2E7";
                        "col.inactive_border" = "0xFF45475A";
                        #col.group_border_active = "0xFFA6E3A1";
                        #col.group_border = "0xFF45475A";
                    };

                    env = optionals cfg.tearing [ "WLR_DRM_NO_ATOMIC,1" ];

                    decoration = {
                        rounding = 10;
                        blur = {
                            enabled = true;
                            size = 3;
                            passes = 2;
                        };

                        drop_shadow = 1;
                        shadow_range = 15;
                        shadow_render_power = 2;
                        shadow_ignore_window = 1;
                        shadow_offset = "2 4";
                        shadow_scale = 1;

                        "col.shadow" = "0xAF1E1E2E";
                    };

                    bezier = [
                        "dupa, 0.1, 0.9, 0.1, 1.05"
                    ];

                    animations = {
                        enabled = true;
                        animation = [
                            "windows, 1, 4, dupa, popin"
                            "windowsOut, 1, 7, dupa, slide"
                            "border, 1, 15, default"
                            "fade, 1, 10, default"
                            "workspaces, 1, 5, dupa, slidevert"
                        ];
                    };

                    dwindle = {
                        no_gaps_when_only = true;
                    };

                    misc = {
                        enable_swallow = false;
                        swallow_regex = "foot";
                        focus_on_activate = true;
                        vrr = 1;
                        vfr = true;
                        animate_manual_resizes = false;
                        animate_mouse_windowdragging = false;
                        force_default_wallpaper = 0;
                    };

                    windowrulev2 = [
                        "float, class:^(Tor Browser)$"
                        "float, class:^(foot)$"
                        "float, class:^(mpv)$"
                        "float, class:^(imv)$"
                        "float, class:^(Vieb)$"
                        "float, title:^(Picture-in-Picture)$"
                        "float, title:^(.*)(Choose User Profile)(.*)$"
                        "float, title:^(blob:null/)(.*)$"

                        "float, class:^(xdg-desktop-portal-gtk)$"
                        "float, class:^(code), title: ^(Open*)"
                        "size 70% 70%, class:^(code), title: ^(Open*)"
                        "center, class: ^(code), title: ^(Open*)"
                        "float, class:^(org.keepassxc.KeePassXC)$"
                        (mkIf config.services.asusd.enable
                            "size 960 670, title:^(ROG Control Center)$")
                    ];

                    bind = [
                        "$mainMod, RETURN, exec, ${foot}/bin/${foot}"
                        "$mainMod SHIFT, Q, killactive"
                        "$mainMod, F, fullscreen, 0"
                        "$mainMod, M, fullscreen, 1"
                        "$mainMod, D, exec, ${pkgs.procps}/bin/pkill anyrun || ${anyrun}/bin/anyrun"
                        "$mainMod, SPACE, togglefloating, active"
                        "$mainMod SHIFT, C, centerwindow"
                        "$mainMod CONTROL, R, bringactivetotop"
                        "$mainMod, P, pin"
                        # workspaces
                        "$mainMod, 1, ${if smwPresent then "split-" else ""}workspace, 1"
                        "$mainMod, 2, ${if smwPresent then "split-" else ""}workspace, 2"
                        "$mainMod, 3, ${if smwPresent then "split-" else ""}workspace, 3"
                        "$mainMod, 4, ${if smwPresent then "split-" else ""}workspace, 4"
                        "$mainMod, 5, ${if smwPresent then "split-" else ""}workspace, 5"
                        "$mainMod, 6, ${if smwPresent then "split-" else ""}workspace, 6"
                        "$mainMod, 7, ${if smwPresent then "split-" else ""}workspace, 7"
                        "$mainMod, 8, ${if smwPresent then "split-" else ""}workspace, 8"
                        "$mainMod, 9, ${if smwPresent then "split-" else ""}workspace, 9"
                        "$mainMod, 0, ${if smwPresent then "split-" else ""}workspace, 10"
                        "$mainMod SHIFT, 1, ${if smwPresent then "split-" else ""}movetoworkspacesilent, 1"
                        "$mainMod SHIFT, 2, ${if smwPresent then "split-" else ""}movetoworkspacesilent, 2"
                        "$mainMod SHIFT, 3, ${if smwPresent then "split-" else ""}movetoworkspacesilent, 3"
                        "$mainMod SHIFT, 4, ${if smwPresent then "split-" else ""}movetoworkspacesilent, 4"
                        "$mainMod SHIFT, 5, ${if smwPresent then "split-" else ""}movetoworkspacesilent, 5"
                        "$mainMod SHIFT, 6, ${if smwPresent then "split-" else ""}movetoworkspacesilent, 6"
                        "$mainMod SHIFT, 7, ${if smwPresent then "split-" else ""}movetoworkspacesilent, 7"
                        "$mainMod SHIFT, 8, ${if smwPresent then "split-" else ""}movetoworkspacesilent, 8"
                        "$mainMod SHIFT, 9, ${if smwPresent then "split-" else ""}movetoworkspacesilent, 9"
                        "$mainMod SHIFT, 0, ${if smwPresent then "split-" else ""}movetoworkspacesilent, 10"
                        # screenshots
                        "$mainMod, S, exec, grimblast save area - | ${pkgs.coreutils-full}/bin/tee \"$(${pkgs.xdg-user-dirs}/bin/xdg-user-dir PICTURES)/Screenshots/$(date +'screenshot-%Y%m%d%H%M%S.png')\" | ${wl-clipboard}/bin/wl-copy && ${pkgs.libnotify}/bin/notify-send \"Screenshot taken\""
                        "$mainMod CONTROL, S, exec, grimblast save area - | ${pkgs.swappy}/bin/swappy -f - -o - | ${pkgs.coreutils-full}/bin/tee \"$(${pkgs.xdg-user-dirs}/bin/xdg-user-dir PICTURES)/Screenshots/$(date +'screenshot-%Y%m%d%H%M%S.png')\" | ${wl-clipboard}/bin/wl-copy && ${pkgs.libnotify}/bin/notify-send \"Screenshot taken\""
                        "$mainMod SHIFT, R, exec, ${hyprland}/bin/hyprctl reload"

                        # TODO fix this maybe
                        "$mainMod, T, exec, grim -g \"$(slurp)\" -t ppm - | tesseract -l pol - - | wl-copy && notify-send \"Copied text: \" \"\\\"$(wl-paste)\\\"\""
                        # TODO fix this
                        "$mainMod, SEMICOLON, exec, ~/.config/rofi/powermenu/type-2/powermenu.sh"
                        "$mainMod, G, togglegroup"
                        # this sometimes fixes the portal
                        "$mainMod CONTROL, X, exec, ${pkgs.systemd}/bin/systemctl --user restart xdg-desktop-portal-hyprland"
                        "$mainMod SHIFT,   X, exec, ${hyprland}/bin/hyprctl kill"
                        # scratchpad binds
                        "$mainMod, B,      togglespecialworkspace, btop"
                        "$mainMod, V,      togglespecialworkspace, pipewire"
                        "$mainMod, N,      togglespecialworkspace, nixos"
                        "$mainMod, X,      togglespecialworkspace, keepassxc"
                        "$mainMod, C, exec, ${hyprlock}/bin/hyprlock"
                        # toggle waybar
                        "$mainMod CONTROL, B, exec, ${pkgs.procps}/bin/pkill waybar || waybar"

                        #"$mainMod, mouse_up, exec, ${hyprland}/bin/hyprctl keyword misc:cursor_zoom_factor $(echo \"$(${hyprland}/bin/hyprctl getoption misc:cursor_zoom_factor -j | ${pkgs.jq}/bin/jq '.float') + 0.01\" | ${pkgs.bc}/bin/bc)"
                        #"$mainMod, mouse_down, exec, ${hyprland}/bin/hyprctl keyword misc:cursor_zoom_factor $(echo \"$(${hyprland}/bin/hyprctl getoption misc:cursor_zoom_factor -j | ${pkgs.jq}/bin/jq '.float') - 0.01\" | ${pkgs.bc}/bin/bc)"

                        #"$mainMod, mouse_up, exec, ${pkgs.libnotify}/bin/notify-send 'mouse_up'"
                        #"$mainMod, mouse_down, exec, ${pkgs.libnotify}/bin/notify-send 'mouse_down'"
                    ];

                    # repeat
                    binde = [
                        # window / monitor focus
                        "$mainMod, H, movefocus, l"
                        "$mainMod, J, movefocus, d"
                        "$mainMod, K, movefocus, u"
                        "$mainMod, L, movefocus, r"
                        "$mainMod CONTROL, J, focusmonitor, l"
                        "$mainMod CONTROL, K, focusmonitor, r"

                        "$mainMod SHIFT,   G, changegroupactive, f"
                        "$mainMod CONTROL, G, changegroupactive, b"
                    ];

                    # locked
                    bindl = [
                        ", XF86AudioMedia, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
                        ", XF86AudioPlay,  exec, ${pkgs.playerctl}/bin/playerctl play-pause"
                        ", XF86AudioStop,  exec, ${pkgs.playerctl}/bin/playerctl stop"
                        ", XF86AudioPrev,  exec, ${pkgs.playerctl}/bin/playerctl previous"
                        ", XF86AudioNext,  exec, ${pkgs.playerctl}/bin/playerctl next"
                        ", XF86AudioMute,  exec, ~/Scripts/notif_volume.sh --toggle-mute"
                    ];

                    # locked + repeat
                    bindle = [
                        ", XF86MonBrightnessUp,   exec, ~/Scripts/notif_brightness.sh set +5%"
                        ", XF86MonBrightnessDown, exec, ~/Scripts/notif_brightness.sh set 5%-"
                        ", XF86AudioRaiseVolume,  exec, ~/Scripts/notif_volume.sh -ui 5"
                        ", XF86AudioLowerVolume,  exec, ~/Scripts/notif_volume.sh -ud 5"
                    ];

                    # mouse
                    bindm = [
                        "$mainMod, mouse:272, movewindow"
                        "$mainMod, mouse:273, resizewindow"
                    ];

                    binds = {
                        pass_mouse_when_bound = false;
                        movefocus_cycles_fullscreen = false;
                    };

                    exec-once = let 
                        # https://wiki.hyprland.org/IPC/#how-to-use-socket2-with-bash
                        handle_hyprland_events = pkgs.writeShellScriptBin "handle_hyprland_events" ''
                            #!/bin/sh

                            handle() {
                                case $1 in
                                    configreloaded*)
                                        ${hyprland}/bin/hyprctl notify 1 2500 "" " Reloading Hyprland..."
                                        ;;
                                esac
                            }

                            ${pkgs.socat}/bin/socat -U - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock |
                            while read -r line; do
                                handle "$line"
                            done
                        '';
                    in [
                        "waybar"

                        # run persistent special workspace windows
                        "[workspace special:nixos silent;tile] cd ~/niksos; ${foot}/bin/foot"
                        (mkIf config.services.asusd.enable
                            "[workspace special:rog silent;tile] ${config.services.asusd.package}/bin/rog-control-center")
                        "[workspace special:keepassxc silent;tile] ${pkgs.keepassxc}/bin/keepassxc"

                        (if config.myOptions.programs.foot.server then "sleep 0.5 && ${pkgs.systemd}/bin/systemctl --user restart foot.service" else ";")

                        "${hyprland}/bin/hyprctl setcursor Bibata-Modern-Classic 24"

                        # TODO do something with this
                        #"${wl-clipboard}/bin/wl-paste --watch cliphist store"

                        "${swww}/bin/swww init"
                        "${wlsunset}/bin/wlsunset -S 06:00 -s 20:00"
                        # TODO fix fcitx5
                        #"fcitx5"
                        # TODO do these do anything anymore
                        "${pkgs.systemd}/bin/systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
                        "${pkgs.dbus}/bin/dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=$XDG_CURRENT_DESKTOP"
                        "rot8 --threshold 0.75"
                        "${handle_hyprland_events}/bin/handle_hyprland_events"
                        "wvkbd-mobintl --hidden -L 500"
                    ];

                    exec = [
                        # kill (almost) everything on special workspaces
                        "${pkgs.procps}/bin/pkill btop"
                        "${pkgs.procps}/bin/pkill helvum"
                        "${pkgs.procps}/bin/pkill pavucontrol"
                        # and run it all again
                        "[workspace special:btop silent;tile] ${foot}/bin/foot -e ${pkgs.btop}/bin/btop"
                        "[workspace special:pipewire silent;tile] ${pkgs.helvum}/bin/helvum"
                        "[workspace special:pipewire silent;tile] ${pkgs.pavucontrol}/bin/pavucontrol"

                        # wait a bit then set the wallpapers
#                        "sleep 0.5 && ${swww}/bin/swww img -o eDP-1 ~/catppuccin-wall0.png"
#                        "sleep 0.5 && ${swww}/bin/swww img -o HDMI-A-1 ~/catppuccin-wall1.png"

                        "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator"
                        "${pkgs.blueman}/bin/blueman-applet"
                    ];

                    layerrule = [
                        # no black border on grimblast screenshots
                        "noanim, ^(selection)$"

                        "blur, ^(waybar)$"
                        "blur, ^(eww)$"

                        # TODO maybe this isn't needed
                        # temporary fix to swaylock screenshoting rofi before locking
                        #"noanim, ^(rofi)$"

                        "blur, ^(anyrun)$"
                    ];

                    plugin = {
                        split-monitor-workspaces = {
                            count = 10;
                            keep_focused = true;
                        };
                    };
                } // cfg.extraSettings;
            };
        };
    };
}
