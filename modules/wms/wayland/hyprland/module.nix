{
  config,
  pkgs,
  lib,
  inputs',
  ...
}: let
  cfg = config.modules.usrEnv.desktops.hyprland;
  inherit (config.meta.mainUser) username;
  inherit
    (inputs'.split-monitor-workspaces.packages)
    split-monitor-workspaces
    ;
  inherit (inputs'.hy3.packages) hy3;
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
      inherit (cfg) package portalPackage;
    };
    # xdg Portal
    xdg.portal = {
      enable = true;
      configPackages = mkDefault [
        cfg.portalPackage
      ];
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        cfg.portalPackage
      ];
      config = {
        common.default = ["gtk" "hyprland"];
      };
    };

    home-manager.users.${username} = {
      wayland.windowManager.hyprland = {
        enable = true;
        inherit (cfg) package;

        # Split-monitor-workspaces provides awesome-like workspace behaviour
        plugins = [
          split-monitor-workspaces
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
