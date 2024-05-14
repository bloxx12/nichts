{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.programs.zathura;
  username = config.modules.other.system.username;
  catppuccin = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "zathura";
    rev = "4eb02fd206de63b2423f6deb58242d352545b52f";
    hash = "sha256-/vD/hOi6KcaGyAp6Az7jL5/tQSGRzIrf0oHjAJf4QbI=";
  };

in {
  options.modules.programs.zathura.enable = mkEnableOption "zathura";

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      xdg.configFile."zathura/catppuccin-mocha".source =
        "${catppuccin}/src/catppuccin-mocha";
      programs.zathura = {
        enable = true;
        extraConfig = ''
          include catppuccin-mocha
        '';
        options = { selection-clipboard = "clipboard"; };
      };
    };
  };
}
