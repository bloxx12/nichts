{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.modules.other.system) username;
  cfg = config.modules.system.programs.editors.kakoune;
  inherit (lib) mkIf mkEnableOption;
  custom-kakoune = pkgs.stdenv.mkDerivation {
    name = "custom-kakoune";
    src = pkgs.fetchFromGitHub {
      owner = "mawww";
      repo = "kakoune";
      rev = "be82047dbf5f74f123e925b96e0e13962a4e0c09";
      hash = "sha256-akSmIe0SUe9re8a90ssrykowCzThZnzqVow9erT+0U4=";
    };

    makeFlags = ["debug=no" "PREFIX=${placeholder "out"}"];

    enableParallellBuilding = true;

    doInstallCheck = false;
    installCheckPhase = ''
      $out/bin/kak -ui json -e "kill 0"
    '';
    postInstall = ''
      cd "$out/share/kak"
      autoload_target=$(readlink autoload)
      rm autoload
      mkdir autoload
      ln -s --relative "$autoload_target" autoload
    '';
  };
in {
  imports = [./mappings.nix];
  options.modules.programs.editors.kakoune.enable = mkEnableOption "kakoune";
  config = {
    environment.systemPackages = [
      custom-kakoune
    ];
  };
}
