{
  config,
  lib,
  ...
}: let
  inherit (config.modules.other.system) username;
  inherit (config.modules.system.hardware) monitors;
  inherit (lib) mapAttrsToList;
  inherit (builtins) toString;
  inherit (config.modules.style.colorScheme) colors;
in {
  home-manager.users.${username} = {
    wayland.windowManager.hyprland.settings = {
      # Hyprland settings
      "$mainMod" = "SUPER";

      # Monitor config
      # Thanks Poz for inspiration, using an attrSet is actually much smarter
      # than using a normal list.
      monitor =
        mapAttrsToList (
          name: m: let
            w = toString m.resolution.x;
            h = toString m.resolution.y;
            refreshRate = toString m.refreshRate;
            x = toString m.position.x;
            y = toString m.position.y;
            scale = toString m.scale;
          in "${name},${w}x${h}@${refreshRate},${x}x${y},${scale}"
        )
        monitors;

      # Input settings
      input = {
        kb_layout = "de,ru, us";
        kb_variant = ",phonetic_winkeys,workman";
        kb_options = "grp:rctrl_rshift_toggle, caps:escape";

        follow_mouse = true;

        repeat_rate = 60;
        repeat_delay = 200;

        touchpad = {
          disable_while_typing = true;
        };
      };

      general = {
        layout = "dwindle";
        gaps_in = 0;
        gaps_out = 0;
        border_size = 2;

        "col.active_border" = "0xff${colors.base07}";
        no_border_on_floating = true;
      };

      plugin = {
        hyprsplit = {
          num_workspaces = 10;
          persistent_workspaces = true;
        };
      };
    };
  };
}
