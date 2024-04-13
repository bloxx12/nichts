{ config, inputs, pkgs, ... }:
let
  fenix = inputs.fenix.packages.${pkgs.system};
  username = config.modules.other.system.username;
in {
    environment.systemPackages = with pkgs; [
            alacritty
            alsa-utils
            asciinema
#            betterbird
            bibata-cursors
            dig
            easyeffects
            element-desktop
            eza
            fastfetch
            (fenix.complete.withComponents [
              "cargo"
              "clippy"
              "rust-src"
              "rustc"
              "rustfmt"
            ])
            ffmpeg_6-full
            flameshot
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
            moc
            ncmpcpp
            neofetch
            neovim
            networkmanagerapplet
            nextcloud-client
            pamixer
            pavucontrol
            pcmanfm
            pfetch
            playerctl
            polkit
            python3
            qbittorrent
            ripgrep
            rustdesk
            rofi
            scc
            sherlock
            signal-desktop-beta
            smartmontools
            spotube
            st
            steam
            strawberry
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
}
