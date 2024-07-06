{config, ...}: let
  inherit (config.modules.other.system) username;
in {
  home-manager.${username}.
  programs.neovim-flake.settings.vim = {
    projects = {
      project-nvim = {
        enable = true;
        setupOpts = {
          manualMode = false;
          detectionMethods = ["lsp" "pattern"];
          patterns = [
            ".git"
            ".hg"
            "Makefile"
            "package.json"
            "index.*"
            ".anchor"
            "flake.nix"
          ];
        };
      };
    };
  };
}
