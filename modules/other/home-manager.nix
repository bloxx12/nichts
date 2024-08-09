{
  config,
  inputs,
  lib,
  self,
  impurity,
  ...
}:
with lib; let
  cfg = config.modules.other.home-manager;
  inherit (config.modules.other.system) username;
in {
  options.modules.other.home-manager = {
    enable = mkEnableOption "home-manager";
    enableDirenv = mkEnableOption "direnv";
  };

  config = mkIf cfg.enable {
    home-manager = {
      verbose = true;
      useUserPackages = true;
      useGlobalPkgs = true;
      backupFileExtension = "hm.old";
      extraSpecialArgs = {inherit inputs self impurity;};
      users.${username} = {
        programs = {
          home-manager.enable = true;
          direnv = mkIf cfg.enableDirenv {
            enable = true;
            nix-direnv.enable = true;
          };
        };

        home = {
          inherit username;
          homeDirectory = "/home/${username}";
          stateVersion = lib.mkDefault "23.11";
        };

        manual = {
          manpages.enable = false;
          html.enable = false;
          json.enable = false;
        };
      };
    };
  };
}
