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
        settings = {
          aliases = {
            c = "clear";
            cc = "cd ~ && clear";
            mv = "mv -iv";
            rm = "trash -v";
            ls = "eza ";
            l = "eza -a ";
            la = "eza -lha --git";
            lg = "lazygit";
            # cd = "z";
            v = "nvim";
            h = "hx";
            k = "kak";
            e = "emacs";
          };
        };
      };
    };
  };
}
