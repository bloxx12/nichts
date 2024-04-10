{ config, inputs, pkgs, ... }:
let
  username = config.myOptions.other.system.username;
in {
    home-manager.users.${username} = {
        home.packages = let
          fenix = inputs.fenix.packages.${pkgs.system};

        in with pkgs; [
            pfetch
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
            lazygit
            neofetch
            zip
            vlc
            zathura
            alacritty
            scc
            texliveFull
            st
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
            neovim
        ];
    };
}
