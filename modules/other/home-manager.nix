{
  config,
  inputs,
  lib,
  self,
  ...
}:
with lib; let
  cfg = config.modules.other.home-manager;
  username = config.modules.other.system.username;
in {
  options.modules.other.home-manager = {
    enable = mkEnableOption "home-manager";
    enableDirenv = mkEnableOption "direnv";
  };

  config = mkIf cfg.enable {
    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      extraSpecialArgs = {inherit inputs self;};
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
      };
    };
  };
}
