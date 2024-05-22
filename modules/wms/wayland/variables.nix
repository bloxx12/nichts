{
  config,
  lib,
  ...
}: let
  cfg = config.modules.wms.wayland;
  hyprland = config.modules.wms.wayland.hyprland;
in {
  options.modules.wms.wayland.enable = lib.mkEnableOption "wayland";
  # options.modules.wms.wayland.hyprland.enable = mkEnableOption "hyprland";
  config = lib.mkIf cfg.enable {
    # lib.mkMerge [
    # {
    environment.variables = {
      NIXOS_OZONE_WL = "1";
      __GL_GSYNC_ALLOWED = "0";
      __GL_VRR_ALLOWED = "0";
      # _JAVA_AWT_WM_NONEREPARENTING = "1";
      # SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
      DISABLE_QT5_COMPAT = "0";
      GDK_BACKEND = "wayland,x11";
      ANKI_WAYLAND = "1";
      DIRENV_LOG_FORMAT = "";
      WLR_DRM_NO_ATOMIC = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      DISABLE_QT_COMPAT = "0";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      MOZ_ENABLE_WAYLAND = "1";
      # WLR_BACKEND = "vulkan";
      # WLR_RENDERER = "vulkan";
      XDG_SESSION_TYPE = "wayland";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      # WLR_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
      # };
      # }
      # Session variables for Hyprland
      # (lib.mkIf (hyprland.enable) {
      # environment.variables = {
      LIBVA_DRIVER_NAME = "nvidia";
      GTK_USE_PORTAL = "1";
      NIXOS_XDG_OPEN_USE_PORTAL = "1";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      # GDK_BACKEND = "wayland";
      WLR_RENDERER_ALLOW_SOFTWARE = "1";
      # QT_QPA_PLATFORM = "wayland";
      # Needed anymore?
      LIBSEAT_BACKEND = "logind";
      # WLR_NO_HARDWARE_CURSORS = "1";
    };
    # })
    # ];
  };
}
