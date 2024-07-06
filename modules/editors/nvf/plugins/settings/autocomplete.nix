{config, ...}: let
  inherit (config.modules.other.system) username;
in {
  programs.neovim-flake.settings.vim = {
    autocomplete = {
      enable = true;
      type = "nvim-cmp";
      mappings = {
        # close = "<C-e>";
        confirm = "<C-y>";
        next = "<C-n>";
        previous = "<C-p>";
        scrollDocsDown = "<C-j>";
        scrollDocsUp = "<C-k>";
      };
    };
  };
}
