{ config, inputs, pkgs, ... }:
let
  username = config.myOptions.other.system.usermame;
in
    home-manager.users.${username} = {
        home.packages = let

        in with pkgs; [
            git
            keepassxc
            eza ripgrep
            signal-desktop-beta
            element-desktop
            steam
            tor-browser-bundle-bin
            betterbird
            telegram-desktop
            libreoffice-fresh
            qbittorrent
            ventoy-full
            zip
            unzip
            gcc
            trash-cli
            bibata-cursors
            networkmanagerapplet
            xclip
            pamixer
            dig
            pcmanfm
            ffmpeg_6-full
            yt-dlp
            (fenix.complete.withComponents [
              "cargo"
              "clippy"
              "rust-src"
              "rustc"
              "rustfmt"
            ])
            polkit
            asciinema
            fastfetch
            alsa-utils
            imagemagick
            pavucontrol
            gdb
            tree
            smartmontools
            krita
            python3
            rustdesk
            httpie
            sherlock
            strawberry
        ];
    };
  }
