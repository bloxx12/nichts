{ inputs, pkgs, ... }:
let
  fenix = inputs.fenix.packages.${pkgs.system};
  nixpkgs-wayland = inputs.nixpkgs-wayland.packages.${pkgs.system};
in {
  environment.systemPackages = with pkgs; [
    alejandra
    alsa-utils
    asciinema
    bibata-cursors
    blueman
    bluetuith
    bluez
    cmake
    difftastic
    dig
    easyeffects
    element-desktop
    evince
    eza
    fastfetch
    feh
    ffmpeg-full
    fftw
    grimblast
    gcc
    gdb
    gnumake
    grc
    grimblast
    git
    helvum
    httpie
    imagemagick
    img2pdf
    imv
    keepassxc
    lazygit
    libtool
    links2
    mars-mips
    gnome.nautilus
    ncmpcpp
    neofetch
    neovim
    networkmanagerapplet
    nextcloud-client
    nicotine-plus
    nil
    nitch
    nixpkgs-wayland.swww
    nmap
    notesnook
    obsidian
    onlyoffice-bin
    pamixer
    pavucontrol
    pdfarranger
    pfetch
    pidgin
    playerctl
    polkit
    python3
    qbittorrent
    ripgrep
    rustdesk
    scc
    scummvm
    sherlock
    signal-desktop-beta
    smartmontools
    strawberry
    telegram-desktop
    texliveFull
    tldr
    thunderbird
    tor-browser-bundle-bin
    trash-cli
    tree
    typst
    unzip
    util-linux
    v4l-utils
    ventoy-full
    vlc
    weechat
    wget
    wireguard-tools
    wl-clipboard
    xdg-utils
    xournalpp
    yt-dlp
    zapzap
    zip
    zoxide
  ];
}
