{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.modules.system.programs.editors.emacs;
  inherit (config.modules.other.system) username;
  inherit (lib) mkIf;

  # Taken from outfoxxed since figuring this out is really annoying.
  newpkgs =
    pkgs.appendOverlays
    (with inputs.emacs-overlay.overlays; [
      emacs
      package
    ]);

  custom-emacs = with newpkgs;
    (emacsPackagesFor emacs-pgtk)
    .emacsWithPackages (epkgs:
      with epkgs; [
        vterm
      ]);
in {
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = with pkgs; [
        custom-emacs
        clang-tools
      ];

      services.emacs = {
        enable = true;
        package = custom-emacs;
      };
    };
  };
}
