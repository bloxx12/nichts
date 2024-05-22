{
  config,
  lib,
  pkgs,
  ...
}: let
  lazyvim-config = pkgs.fetchFromGitHub {
    owner = "Dragyx";
    repo = "lazyvim-config";
    rev = "d799724f48199d81ca6c8abb5951860fbf8fa0df";
    hash = "sha256-NF92CweRFQ1qZS8NXoTUEljazRGXgXS2AuDt5IWmwBc=";
  };
  cfg = config.modules.programs.neovim-old;
  username = config.modules.other.system.username;
in {
  options.modules.programs.neovim-old.enable = lib.mkEnableOption "neovim-old";

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = with pkgs; [lazygit ripgrep fd gcc xclip rust-analyzer];
      programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        defaultEditor = true;
      };

      xdg.configFile."nvim" = {
        enable = true;
        source = lazyvim-config;
        recursive = true;
      };
    };
  };
}
