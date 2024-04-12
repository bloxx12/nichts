_: {
    imports = [
        ./i3.nix
    ];
    home.file.".config/i3(config)".source = ./config;
}
