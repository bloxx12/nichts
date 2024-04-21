{ config, lib, pkgs, ... }:

let
  
in
{
  environment.systemPackages = with pkgs; [
    prismlauncher
    glfw-wayland-minecraft # Use these parameters in the prism launcher: -Dfml.earlyprogresswindow=false -Dorg.lwjgl.glfw.libname=/nix/store/ypkdx5844pp1vdw2z2nmnf2nb9kgl0mp-glfw-wayland-minecraft-unstable-2023-06-01/lib/libglfw.so
    mmex
  ];
}
