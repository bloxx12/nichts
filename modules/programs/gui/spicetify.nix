{
  inputs,
  inputs',
  pkgs,
  ...
}: let
  spicePkgs = inputs'.spicetify-nix.legacyPackages;
in {
  imports = [
    inputs.spicetify-nix.nixosModules.default
  ];
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle
    ];
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };
}
