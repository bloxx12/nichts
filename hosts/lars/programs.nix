{ config, inputs, pkgs, ... }:
let
  username = config.modules.other.system.username;
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
            obsidian
            neofetch
            zip
            vlc
            zathura
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
            tmux
            kitty
            nextcloud-client
            vscode
            grim
            slurp
            wl-clipboard
            pavucontrol
            wofi
            dolphin
            xdg-utils # xdg-mime script
            webcord
            element-desktop
	        swww
            toipe
            keepassxc
            yubikey-personalization-gui
            yubikey-personalization
            yubioath-flutter
            fzf
            tldr
            feh
        ];
    };
}
