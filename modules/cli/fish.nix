{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.programs.fish;
  inherit (config.modules.other.system) username;
  inherit (config.modules.other.system) gitPath;
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
      shells = [pkgs.fish];
      pathsToLink = ["/share/fish"];
    };

    home-manager.users.${username} = {
      home.packages = with pkgs; [nix-output-monitor];
      programs = {
        zoxide.enable = true;
        zoxide.enableFishIntegration = true;
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
              name = "tide";
              inherit (pkgs.fishPlugins.tide) src;
            }
          ];
          shellAbbrs =
            {
              c = "clear";
              cc = "cd ~ && clear";
              mv = "mv -iv";
              rm = "trash -v";
              ls = "eza --icons";
              l = "eza -a --icons";
              la = "eza -lha --icons --git";
              kys = "shutdown now";
              lg = "lazygit";
              cd = "z";
              "..." = "cd ../..";
              v = "nvim";
              h = "hx";
              k = "kak";
              e = "emacs";
              update = ''nh os switch "${gitPath}"'';
              flake = "cd '${gitPath}'";
            }
            // cfg.extraAliases;
        };
      };
    };
  };
}
