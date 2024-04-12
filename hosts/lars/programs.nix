{ config, inputs, pkgs, ... }:
let
  username = config.myOptions.other.system.username;
in {
    home-manager.users.${username} = {
        home.packages = let
          fenix = inputs.fenix.packages.${pkgs.system};

        in with pkgs; [
	    neofetch
            git
	    trash-cli
            element-desktop
            steam
            libreoffice-fresh
            ventoy-full
            lazygit
	    # obsidian
            neofetch
            zip
            vlc
            zathura
            alacritty
            unzip
            gcc
            bibata-cursors
            networkmanagerapplet
            xclip
            pamixer
            pcmanfm
            ffmpeg_6-full
            (fenix.complete.withComponents [
              "cargo"
              "clippy"
              "rust-src"
              "rustc"
              "rustfmt"
            ])
            polkit
            fastfetch
            alsa-utils
            gdb
            tree
            smartmontools
            python3
            rustdesk
            neovim
	    tmux
        ];
    };
}
