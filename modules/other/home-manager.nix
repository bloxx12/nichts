{
    config,
    inputs,
    lib,
    self,
    ...
}: with lib; let
    cfg = config.myOptions.other.home-manager;
    username = config.myOptions.other.system.username;
in {
    options.myOptions.other.home-manager = {
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
