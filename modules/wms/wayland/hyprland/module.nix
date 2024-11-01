{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.modules.usrEnv.desktops.hyprland;
  inherit (config.meta.mainUser) username;
  # inherit (inputs.hyprsplit.packages.${pkgs.system}) hyprsplit;
  inherit (lib) mkIf mkDefault;
in {
  imports = [
    ./binds.nix
    ./decorations.nix
    ./exec.nix
    ./settings.nix
    ./workspaces.nix
  ];
  # we disable the default hyprland module
  disabledModules = ["programs/hyprland.nix"];

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      package = pkgs.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
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

    home-manager.users.${username} = {
      wayland.windowManager.hyprland = {
        enable = true;
        package = pkgs.hyprland;

        # Split-monitor-workspaces provides awesome-like workspace behaviour
        plugins = [
          pkgs.hyprlandPlugins.hyprsplit
          pkgs.hyprlandPlugins.hypr-dynamic-cursors
        ];

        # Xwayland for X applications
        xwayland.enable = true;
        # No idea why I set this
        systemd = {
          enable = true;
          variables = ["--all"];
        };
      };
    };
  };
}
