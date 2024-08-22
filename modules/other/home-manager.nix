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

  # NOTE: to keep this configuration sane and simple,
  # we import the NixOS home manager module instead of the
  # standalone one.
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  config = mkIf cfg.enable {
    home-manager = {
      # Verbosity is great, give me verbosity.
      verbose = true;

      useUserPackages = true;
      useGlobalPkgs = true;

      #
      backupFileExtension = "hm.old";
      extraSpecialArgs = {inherit inputs self;};
      users.${username} = {
        programs = {
          home-manager.enable = true;
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
