{
  inputs,
  lib,
  pkgs,
  ...
}: {
  programs.nvf = {
    enable = true;

    defaultEditor = true;
    enableManpages = true;

    settings = {
      vim = {
        # use neovim-unwrapped from nixpkgs
        package = pkgs.neovim-unwrapped;

        viAlias = true;
        vimAlias = true;

        withNodeJs = false;
        withPython3 = false;
        withRuby = false;

        # Prevent swapfile and backupfile from being created
        preventJunkFiles = true;

        # Make use of the clipboard for default yank and paste operations. Don’t use * and +
        useSystemClipboard = true;
        spellcheck = {
          enable = true;
          languages = ["en" "de"];
        };

        # Whether to enable the experimental Lua module loader to speed up the start up process
        enableLuaLoader = true;
        enableEditorconfig = true;

        debugMode = {
          enable = false;
          logFile = "/tmp/nvim.log";
        };
      };
    };
  };
}
