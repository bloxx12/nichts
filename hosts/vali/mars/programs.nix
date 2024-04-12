{ config, inputs, pkgs, ... }:
let
  username = config.myOptions.other.system.username;
in {
    home-manager.users.${username} = {
        home.packages = let
          fenix = inputs.fenix.packages.${pkgs.system};

        in with pkgs; [
            alacritty
            alsa-utils
            asciinema
            betterbird
            bibata-cursors
            chromium
            dig
            easyeffects
            element-desktop
            eza
            ripgrep
            fastfetch
            (fenix.complete.withComponents [
              "cargo"
              "clippy"
              "rust-src"
              "rustc"
              "rustfmt"
            ])
            ffmpeg_6-full
            foot
            gcc
            gdb
            grimblast
            git
            httpie
            imagemagick
            keepassxc
            krita
            lazygit
            libreoffice-fresh
            neofetch
            neovim
            networkmanagerapplet
            nextcloud-client
            pamixer
            pavucontrol
            pcmanfm
            pfetch
            polkit
            python3
            qbittorrent
            rustdesk
            rofi
            scc
            sherlock
            signal-desktop-beta
            smartmontools
            st
            steam
            strawberry-qt6
            telegram-desktop
            texliveFull
            thunderbird
            tor-browser-bundle-bin
            trash-cli
            tree
            unzip
            ventoy-full
            vesktop
            vlc
            xclip
            yt-dlp
            zathura
            zip
        ];
    };
}
