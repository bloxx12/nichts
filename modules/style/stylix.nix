{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: let
  cfg = config.modules.usrEnv.style.stylix;
  inherit (config.modules.usrEnv.style.stylix) image cursor fontsizes;
  inherit (config.modules.other.system) username;
  inherit (lib) mkIf;
in {
  imports = [inputs.stylix.nixosModules.stylix];
  config = mkIf cfg.enable {
    stylix = {
      enable = false;
      autoEnable = false;
      homeManagerIntegration = {
        followSystem = true;
        autoImport = true;
      };
      # base16Scheme = scheme;
      base16Scheme = {
        scheme = "3024-custom";
        # base00 = "090300"; #  ----
        base00 = "000000"; # Black
        base01 = "3a3432"; #  Dark grey
        base02 = "4a4543"; #  Lighter grey
        base03 = "5c5855"; #  Light greLight grey
        base04 = "807d7c"; #  +
        base05 = "a5a2a2"; #  ++
        base06 = "d6d5d4"; #  +++
        base07 = "f7f7f7"; #  ++++
        base08 = "db2d20"; #	red
        base09 = "e8bbd0"; #	orange
        base0A = "fded02"; #	yellow
        base0B = "01a252"; #	green
        base0C = "b5e4f4"; #	aqua
        base0D = "01a0e4"; #	blue
        base0E = "a16a94"; #	purple
        base0F = "cdab53"; #	brown
      };

      inherit image;
      polarity = "dark";
      cursor = {
        inherit (cursor) size package name;
        # package = pkgs.bibata-cursors;
        # name = "Bibata-Modern-Classic";
      };

      opacity = {
        applications = 1.0;
        popups = 1.0;
        desktop = 1.0;
        terminal = 1.0;
      };
      targets = {
        console.enable = true;
        fish.enable = true;
        grub.enable = false;
        grub.useImage = true;
        gtk.enable = true;
        lightdm.enable = true;
        nixos-icons.enable = true;
        plymouth.enable = true;
        plymouth.logoAnimated = true;
      };
    };
    home-manager.users.${username} = {
      stylix.targets = {
        btop.enable = true;
        helix.enable = true;
        dunst.enable = true;
        firefox.enable = true;
        foot.enable = true;
        fzf.enable = true;
        hyprland.enable = true;
        lazygit.enable = true;
        emacs.enable = true;
        kde.enable = true;
        yazi.enable = true;
        zellij.enable = true;
      };
    };
  };
}
