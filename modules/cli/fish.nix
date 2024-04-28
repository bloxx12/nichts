{
    config,
    lib,
    pkgs,
    ...
}: with lib; let
    cfg = config.modules.programs.fish;
    username = config.modules.other.system.username;
in {
    options.modules.programs.fish = {
        enable = mkEnableOption "fish";
        extraAliases = mkOption {
            type = types.attrs;
            description = "extra shell aliases";
            default = {};
        };
        profiling = mkOption {
            type = types.bool;
            description = "enable zsh profiling";
            default = false;
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
              programs.fish = {
                  enable = true;
                  interactiveShellInit = "set fish_greeting";
                  plugins = [
                  ];
                  shellAliases = {

                      cl = "clear";
                      cp = "cp -ivr";
                      mv = "mv -iv";
                      rm = "trash -v";
                      l = "eza -a --icons";
                      e = "eza -lha --icons --git";
                      untar = "tar -xvf";
                      untargz = "tar -xzf";
                      mnt = "udisksctl mount -b";
                      umnt = "udisksctl unmount -b";
                      v = "nvim";
                      kys = "shutdown now";
                      gpl = "curl https://www.gnu.org/licenses/gpl-3.0.txt -o LICENSE";
                      agpl = "curl https://www.gnu.org/licenses/agpl-3.0.txt -o LICENSE";
                      g = "git";
                      gs = "g stash";
                      n = "nix";
                      woman = "man";
                      open = "xdg-open";
                      ":q" = "exit";
                  } // cfg.extraAliases;
              };
        };
    };
}
