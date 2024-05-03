{ config, inputs, pkgs, ... }:
let
  fenix = inputs.fenix.packages.${pkgs.system};
  username = config.modules.other.system.username;
in {
    environment.systemPackages = with pkgs; [
            alacritty
            alsa-utils
            android-tools
            asciinema
            bibata-cursors
            blanket
            blugon
            difftastic
            dig
            dmenu
            easyeffects
            element-desktop
            evince
            eza
            fastfetch
            feh
            (fenix.complete.withComponents [
              "cargo"
              "clippy"
              "rust-src"
              "rustc"
              "rustfmt"
            ])
            ffmpeg-full
            fftw flameshot
            heroic
            imv
            gcc
            gdb
            gnumake
            grc
            grimblast
            git
            httpie
            i3lock
            imagemagick
            img2pdf
            keepassxc
            krita
            lazygit
            librewolf
            links2
            mars-mips
            ncmpcpp
            neofetch
            neovim
            networkmanagerapplet
            nextcloud-client
            nicotine-plus
            nitrogen
            nmap
            notesnook
            onlyoffice-bin
            pamixer
            pavucontrol
            picom
            pcmanfm
            pdfarranger
            pfetch
            playerctl
            polkit
            python3
            qbittorrent
            ripgrep
            rustdesk
            rofi
            scc
            scrot
            scummvm
            sherlock
            signal-desktop-beta
            smartmontools
            spotube
            steam
            strawberry
            telegram-desktop
            texliveFull
            trilium-desktop
            thunderbird
            tor-browser-bundle-bin
            trash-cli
            tree
            unzip
            util-linux
            ventoy-full
            vlc
            weechat
            wget
            wireguard-tools 
            xclip
            xfce.thunar
            xorg.libX11.dev
            xorg.libXft
            xorg.libXinerama
            xournalpp
            yt-dlp
            zapzap
            zathura
            zip
            zoxide
        ];
}
