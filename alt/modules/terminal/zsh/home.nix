{ pkgs, config, ... }

{
  programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableAutoSuggestions = true;

      shellAliases = {
          c = "clear";
          cc = "cd && clear";
          la = "eza -lah";
          ls = "eza"
          update = "sudo nixos-rebuild switch --flake '/home/vali/.flake/'#laptop";
          nv = "nvim";
          sunv = "sudo nvim";
      };
      history.size = 10000;
      history.path = "${config.xdg.dataHome}/zsh/history";
      
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "thefuck" ];
      };
      home.packages = with pkgs; [ thefuck ];
      programs.zoxide = {
          enable = true;
          enableZshIntegration = true;
        }
    }
}
