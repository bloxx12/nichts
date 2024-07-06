{config, ...}: let
  inherit (config.modules.other.system) username;
in {
  programs.neovim-flake.settings.vim = {
    assistant.copilot = {
      enable = true;
      cmp.enable = true;
    };
  };
}