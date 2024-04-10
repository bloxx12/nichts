{
    config,
    lib,
    ...
}: with lib; let
    cfg = config.myOptions.programs.starship;
    username = config.myOptions.other.system.username;
in {
    options.myOptions.programs.starship.enable = mkEnableOption "starship";

    config = mkIf cfg.enable {
        home-manager.users.${username} = {
            programs.starship = {
                enable = true;
                enableZshIntegration = config.myOptions.programs.zsh.enable;
                settings = {
                    add_newline = false;
                    command_timeout = 1000;
                    line_break = {
                        disabled = true;
                    };
                    directory = {
                        truncation_length = 3;
                        truncate_to_repo = false;
                        truncation_symbol = "…/";
                    };
                    c.symbol = " ";
                    directory.read_only = " 󰌾";
                    git_branch.symbol = " ";
                    haskell.symbol = " ";
                    hostname.ssh_symbol = " ";
                    java.symbol = " ";
                    kotlin.symbol = " ";
                    meson.symbol = "󰔷 ";
                    nix_shell.symbol = " ";
                    package.symbol = "󰏗 ";
                    rust.symbol = " ";
                };
            };
        };
    };
}
