{
  config,
  pkgs,
  ...
}: let
  inherit (config.modules.other.system) username;
  inherit (config.modules.style) cursor;
  inherit (builtins) toString;
in {
  home-manager.users.${username} = {
    wayland.windowManager.hyprland.settings = {
      # Hyprland settings
      # Programs which get executed at Hyprland start.
      exec-once = [
        "hyprctl setcursor ${cursor.name} ${toString cursor.size}"
        #start waybar
        "${pkgs.waybar}/bin/waybar"

        # run persistent special workspace windows
        "[workspace special:nixos; silent;tile] ${pkgs.foot}/bin/foot -D ~/projects/nichts"

        "[workspace special:keepassxc; silent;tile] ${pkgs.keepassxc}/bin/keepassxc"
        "[workspace special:audio; silent;tile] ${pkgs.pavucontrol}/bin/pavucontrol"
        "[workspace special:audio; silent;tile] ${pkgs.pwvucontrol}/bin/pwvucontrol"

        "${pkgs.swww}/bin/swww-daemon"

        "${pkgs.wlsunset}/bin/wlsunset -S 06:00 -s 20:00"
      ];
    };
  };
}
