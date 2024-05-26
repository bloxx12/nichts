{
  config,
  lib,
  inputs,
  ...
}: let
  cfg = config.modules.editors.nixvim;
in {
  options.modules.editors.nixvim.enable = lib.mkEnableOption "nixvim";
  imports = [
    inputs.nixvim.nixosModules.nixvim
    ./keys.nix
    ./settings.nix
    ./plug/completion/cmp.nix
    #./plug/completion/copilot-cmp.nix
    #./plug/completion/lspkind.nix
    ./plug/git/gitlinker.nix
    ./plug/git/gitsigns.nix
    ./plug/git/lazygit.nix
    ./plug/git/worktree.nix

    ./plug/lsp/conform.nix
    ./plug/lsp/fidget.nix
    ./plug/lsp/hlchunk.nix
    ./plug/lsp/lsp.nix
    ./plug/lsp/lspsaga.nix
    ./plug/lsp/none-ls.nix
    ./plug/lsp/trouble.nix

    ./plug/snippets/luasnip.nix

    ./plug/statusline/lualine.nix
    #./plug/statusline/staline.nix

    #./plug/treesitter/treesitter-context.nix
    ./plug/treesitter/treesitter-textobjects.nix
    ./plug/treesitter/treesitter.nix

    ./plug/ui/alpha.nix
    ./plug/ui/btw.nix
    ./plug/ui/bufferline.nix
    ./plug/ui/noice.nix
    ./plug/ui/nvim-notify.nix
    ./plug/ui/telescope.nix

    ./plug/utils/comment.nix
    #./plug/utils/copilot.nix
    ./plug/utils/flash.nix
    ./plug/utils/hardtime.nix
    #./plug/utils/harpoon.nix
    ./plug/utils/grapple.nix
    ./plug/utils/illuminate.nix
    ./plug/utils/nvim-autopairs.nix
    ./plug/utils/oil.nix
    ./plug/utils/undotree.nix
    ./plug/utils/ufo.nix
    ./plug/utils/whichkey.nix
    ./plug/utils/lazy.nix
  ];
  options = {
    theme = lib.mkOption {
      default = "gruvbox";
      type = lib.types.enum ["paradise" "decay" "mountain" "tokyonight" "everforest" "everblush" "jellybeans" "aquarium" "gruvbox"];
    };
  };
  config = lib.mkIf cfg.enable {
    programs.nixvim.enable = true;
    theme = "gruvbox";
    programs.nixvim.extraConfigLua = ''
      _G.theme = "${config.theme}"
    '';
  };
}
