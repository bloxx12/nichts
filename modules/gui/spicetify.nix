{
  config,
  pkgs,
  lib,
  inputs,
  inputs',
  ...
}: let
  cfg = config.modules.system.programs.spotify;
  inherit (config.modules.other.system) username;
  spicePkgs = inputs'.spicetify-nix.legacyPackages;
in {
  config = lib.mkIf cfg.enable {
    home-manager.users.${username} = {
      imports = [inputs.spicetify-nix.homeManagerModules.default];
      programs.spicetify = {
        enable = true;
        spotifyPackage = pkgs.spotify;
        theme = spicePkgs.themes.catppuccin;
        colorScheme = "mocha";
        enabledExtensions = with spicePkgs.extensions; [
          #   shuffle
          #   popupLyrics
          adblock
          #   betterGenres
          #   playlistIcons
        ];
      };
    };
  };
}
