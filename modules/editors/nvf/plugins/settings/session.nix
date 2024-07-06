{config, ...}: let
  inherit (config.modules.other.system) username;
in {
  programs.neovim-flake.settings.vim = {
    session.nvim-session-manager = {
      enable = false;
      setupOpts.autoload_mode = "Disabled"; # misbehaves with dashboard
    };
  };
}
