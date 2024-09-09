# NOTE: Credits go to raf aka Notashelf, who wrote not only nvf
# but also most of this configuration, the
# link to his repo is in the README.md
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (builtins) filter map toString;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (lib.strings) hasSuffix fileContents;
  inherit (lib.attrsets) genAttrs;
  inherit (lib) mkIf;

  cfg = config.modules.system.programs.editors.neovim;
  nvf = inputs.neovim-flake;
  inherit (nvf.lib.nvim.dag) entryBefore;
in {
  config = mkIf cfg.enable {
    programs.neovim-flake = {
      enable = true;

      defaultEditor = true;
      enableManpages = true;

      settings = {
        vim = {
          # use neovim-unwrapped from nixpkgs
          # alternatively, neovim-nightly from the neovim-nightly overlay
          # via inputs.neovim-nightly.packages.${pkgs.stdenv.system}.neovim
          package = pkgs.neovim-unwrapped;
          viAlias = false;
          vimAlias = true;

          withNodeJs = false;
          withPython3 = false;
          withRuby = false;

          preventJunkFiles = true;
          useSystemClipboard = true;
          tabWidth = 4;
          autoIndent = true;
          spellcheck = {
            enable = true;
            languages = ["en" "de"];
          };

          enableLuaLoader = true;
          enableEditorconfig = true;

          debugMode = {
            enable = false;
            logFile = "/tmp/nvim.log";
          };

          additionalRuntimePaths = [
            ./runtime
            ./runtime
          ];

          # additional lua configuration that I can append
          # or, to be more precise, randomly inject into
          # the lua configuration of nvf.
          # This is recursively read from the lua
          # directory, so we do not need to use require

          luaConfigRC = let
            # get the name of each lua file in the lua directory, where setting files reside
            # and import them recursively
            configPaths = filter (hasSuffix ".lua") (map toString (listFilesRecursive ./lua));

            # generates a key-value pair that looks roughly as follows:
            #  `<filePath> = entryAnywhere ''<contents of filePath>''`
            # which is expected by neovim-flake's modified DAG library
            luaConfig = genAttrs configPaths (file:
              entryBefore ["luaScript"] ''
                ${fileContents "${file}"}
              '');
          in
            luaConfig;
        };
      };
    };
  };
}
