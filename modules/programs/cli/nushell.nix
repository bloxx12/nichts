{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.modules.other.system) username;
  inherit (lib) mkIf;
  cfg = config.modules.system.programs.nushell;
in {
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.nushell = {
        enable = true;
        package = pkgs.nushell;
        shellAliases = {
          c = "clear";
          cc = "cd; clear";
          mv = "mv -iv";
          rm = "trash -v";
          lg = "lazygit";
          v = "nvim";
          h = "hx";
          e = "emacs";
        };
      };
    };
  };
}
