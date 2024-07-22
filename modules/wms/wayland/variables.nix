{
  config,
  lib,
  ...
}: let
  cfg = config.modules.wms.wayland;
  inherit (lib) mkIf mkEnableOption;
in {
  options.modules.wms.wayland.enable = mkEnableOption "wayland";
  config = mkIf cfg.enable {
    environment.variables = {
      NIXOS_OZONE_WL = "1";
      __GL_GSYNC_ALLOWED = "0";
      __GL_VRR_ALLOWED = "0";

      GDK_BACKEND = "wayland";
      QT_QPA_PLATFORM = "wayland";

      MOZ_ENABLE_WAYLAND = "1";

      SDL_VIDEODRIVER = "wayland";

      CLUTTER_BACKEND = "wayland";

      LIBVA_DRIVER_NAME = "nvidia";
      GTK_USE_PORTAL = "1";

      NIXOS_XDG_OPEN_USE_PORTAL = "1";

      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";

      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      WLR_RENDERER_ALLOW_SOFTWARE = "1";

      LIBSEAT_BACKEND = "logind";
    };
  };
}
