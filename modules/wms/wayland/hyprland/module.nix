{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.modules.usrEnv.desktops.hyprland;
  # inherit (inputs.hyprsplit.packages.${pkgs.system}) hyprsplit;
  inherit (lib) mkIf mkDefault;
in {
  imports = [
    ./binds.nix
    ./decorations.nix
    ./exec.nix
    ./settings.nix
    ./workspaces.nix
    ./nixos-module.nix
  ];
  # we disable the default hyprland module
  disabledModules = ["programs/hyprland.nix"];

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      package = pkgs.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      plugins = [
        pkgs.hyprlandPlugins.hyprsplit
        # pkgs.hyprlandPlugins.hypr-dynamic-cursors
      ];
    };
    # xdg Portal
    xdg.portal = {
      enable = true;
      configPackages = mkDefault [
        pkgs.xdg-desktop-portal-hyprland
      ];
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
      ];
      config = {
        common.default = ["gtk" "hyprland"];
      };
    };
  };
}
