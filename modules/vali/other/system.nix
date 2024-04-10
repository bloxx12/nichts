{
    config,
    lib,
    ...
}: with lib; let
    cfg = config.myOptions.other.system;
in {
    options.myOptions.other.system = {
        hostname = mkOption {
            description = "hostname for this system";
            type = types.str;
        };

        username = mkOption {
            description = "username for this system";
            type = types.str;
        };
    };

    config = {
        networking.hostName = cfg.hostname;

        users.users.${cfg.username} = {
            isNormalUser = true;
            extraGroups = [ "wheel" ];
        };
    };
}
