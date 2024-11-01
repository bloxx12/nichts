{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.programs.fish;
  inherit (config.modules.other.system) username;
in {
  options.modules.programs.fish = {
    enable = mkEnableOption "fish";
    extraAliases = mkOption {
      type = types.attrs;
      description = "extra shell aliases";
      default = {};
    };
  };

  config = mkIf cfg.enable {
    programs.fish.enable = true;

    # homix.".config/fish/config.fish".source = fishinit;
    # users.users.${username}.shell = pkgs.fish;

    environment = {
      # shells = [pkgs.fish];
      # pathsToLink = ["/share/fish"];
    };

    home-manager.users.${username} = {
      programs = {
        fish = {
          enable = true;
          interactiveShellInit = "set fish_greeting";
          plugins = [
            {
              name = "sponge";
              inherit (pkgs.fishPlugins.sponge) src;
            }
            {
              name = "done";
              inherit (pkgs.fishPlugins.done) src;
            }
            {
              name = "puffer";
              inherit (pkgs.fishPlugins.puffer) src;
            }
          ];
          shellAbbrs = {
            c = "clear";
            cc = "cd ~ && clear";
            mv = "mv -iv";
            rm = "trash -v";
            ls = "eza ";
            l = "eza -a ";
            la = "eza -lha --git";
            lg = "lazygit";
            cd = "z";
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
