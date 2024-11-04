{config, ...}: let
  inherit (config.modules.other.system) username;
in {
  programs.hyprland.settings = {
    #Decoration settings
    decoration = {
      rounding = 0;
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
    };
    # Bezier curves for aninmations.
    # Generate your own at https://www.cssportal.com/css-cubic-bezier-generator/
    bezier = [
      "dupa, 0.1, 0.9, 0.1, 1.05"
    ];
    # Hyprland anomations, using the above bezier curves
    animations = {
      enabled = false;
      animation = [
        "windows, 1, 4, dupa, popin"
        "windowsOut, 1, 4, dupa, slide"
        "border, 1, 15, default"
        "fade, 1, 10, default"
        "workspaces, 1, 5, dupa, slidevert"
      ];
    };

    cursor = {
      hide_on_key_press = true;
      no_hardware_cursors = true;
    };

    misc = {
      enable_swallow = true;
      swallow_regex = "foot";
      focus_on_activate = true;
      vrr = 1;
      vfr = true;
      animate_manual_resizes = false;
      animate_mouse_windowdragging = false;
      force_default_wallpaper = 0;
    };

    # Window rules for some programs.
    windowrulev2 = [
      "float, class:^(Tor Browser)$"
      "float, class:^(mpv)$"
      "float, class:^(imv)$"
      "float, title:^(Picture-in-Picture)$"
      "float, title:^(.*)(Choose User Profile)(.*)$"
      "float, title:^(blob:null/)(.*)$"
      "float, class:^(xdg-desktop-portal-gtk)$"
      "float, class:^(code), title: ^(Open*)"
      "size 70% 70%, class:^(code), title: ^(Open*)"
      "center, class: ^(code), title: ^(Open*)"
      "float, class:^(org.keepassxc.KeePassXC)$"
    ];
  };
}
