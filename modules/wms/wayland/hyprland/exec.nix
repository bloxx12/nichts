{
  config,
  pkgs,
  ...
}: let
  inherit (config.modules.style) cursor;
  inherit (builtins) toString;
in {
  programs.hyprland.settings = {
    # Hyprland settings
    # Programs which get executed at Hyprland start.
    exec-once = [
      "hyprctl setcursor ${cursor.name} ${toString cursor.size}"

      "[workspace special:keepassxc; silent;tile] ${pkgs.keepassxc}/bin/keepassxc"
      "[workspace special:audio; silent;tile] ${pkgs.pwvucontrol}/bin/pwvucontrol"

      "${pkgs.swww}/bin/swww-daemon"

      "${pkgs.wlsunset}/bin/wlsunset -S 06:00 -s 20:00"
      "${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent"
      "hyprctl dispatch split-workspace 1"
    ];
  };
}
