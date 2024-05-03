{ config, lib, ... }:
with lib; let
    cfg = config.modules.programs.stylix;
    username = config.modules.other.system.username;
in {
    options.modules.programs.stylix.enable = mkEnableOption "stylix";

    config = mkIf cfg.enable {
        home-manager.users.${username} = {
            programs.btop = {
                enable = true;
                settings = {
                    theme_background = false;
                    vim_keys = true;
                    update_ms = 1000;
                    cpu_single_graph = true;
                    clock_format = "%X";
                    use_fstab = true;
                    io_mode = true;
                    net_sync = true;
                    net_iface = "enp4s0";
                    log_level = "WARNING";
                };
            };
        };
    };
}
