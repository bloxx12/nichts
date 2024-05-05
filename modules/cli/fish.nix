{
    config,
    lib,
    pkgs,
    ...
}: with lib; let
    cfg = config.modules.programs.fish;
    username = config.modules.other.system.username;
    hostname = config.modules.other.system.hostname;
    gitPath = config.modules.other.system.gitPath;
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

        users.users.${username}.shell = pkgs.fish;

        environment = {
            shells = [ pkgs.fish ];
            pathsToLink = [ "/share/fish" ];
        };

        home-manager.users.${username} = {
              home.packages = with pkgs; [ nix-output-monitor ];
              programs.zoxide.enable = true;
              programs.zoxide.enableFishIntegration = true;
              programs.fish = {
                  enable = true;
                  interactiveShellInit = "set fish_greeting";
                  plugins = [
                       { name = "grc"; src = pkgs.fishPlugins.grc.src; }
                       { name = "sponge"; src = pkgs.fishPlugins.sponge.src; }
                       { name = "done"; src = pkgs.fishPlugins.done.src; }
                       { name = "colored_man_pages"; src = pkgs.fishPlugins.colored-man-pages.src; }
                       { name = "tide"; src = pkgs.fishPlugins.tide.src; }
                  ];
                  shellAbbrs = {
                      c = "clear";
                      cc = "cd ~ && clear";
                      mv = "mv -iv";
                      rm = "trash -v";
                      ls = "eza";
                      l = "eza -a --icons";
                      la = "eza -lha --icons --git";
                      kys = "shutdown now";
                      lg = "lazygit";
                      cd = "z";
                      v = "nvim";
                      e = "emacs";
                      update = "sudo nixos-rebuild switch --flake \"${gitPath}#${hostname}\"";
                      flake = "cd '${gitPath}'";
                  } // cfg.extraAliases;
              };
        };
    };
}
