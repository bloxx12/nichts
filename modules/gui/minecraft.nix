{ config, lib, inputs, pkgs, ... }:
with lib;
let
  username = config.modules.other.system.username;
  cfg = config.modules.programs.minecraft;
in {
  options.modules.programs.minecraft = {
    enable = mkEnableOption "minecraft";
    wayland = mkEnableOption "wayland";
  };

  config = mkIf cfg.enable {
    # Set wayland environment flag
    environment.variables =
      mkIf cfg.wayland { __GL_THREADED_OPTIMIZATIONS = 0; };
    # Install glfw-wayland-minecraft
    environment.systemPackages = with pkgs;
      mkIf cfg.wayland [
        glfw-wayland-minecraft # Use these parameters in the prism launcher: -Dfml.earlyprogresswindow=false -Dorg.lwjgl.glfw.libname=/nix/store/ypkdx5844pp1vdw2z2nmnf2nb9kgl0mp-glfw-wayland-minecraft-unstable-2023-06-01/lib/libglfw.so
      ];

    home-manager.users.${username} = {
      # Install minecraft
      home.packages = with pkgs; [ prismlauncher ];
    };
  };
}
