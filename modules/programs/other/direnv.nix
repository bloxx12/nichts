{
  config,
  pkgs,
  ...
}: let
  inherit (config.modules.other.system) username;
in {
  config = {
    programs.direnv = {
      enable = true;
      package = pkgs.direnv;
      nix-direnv.package = pkgs.nix-direnv;

      # PLEASE BE SILENT
      silent = true;
      # We want direnv to load in our nix dev shells
      loadInNixShell = true;

      enableBashIntegration = true;
      enableFishIntegration = true;
    };
  };
}
