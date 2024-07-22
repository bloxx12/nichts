{
  inputs',
  pkgs,
  ...
}: let
  nixpkgs-wayland = inputs'.nixpkgs-wayland.packages;
in {
  environment.systemPackages = with pkgs; [
    alejandra
    alsa-utils
    asciinema
    bibata-cursors
    blueman
    bluetuith
    bluez
    #botany
    broot
    browsh
    bun
    cachix
    calc
    calcure
    calibre
    cbonsai
    cmake
    cmus
    difftastic
    dig
    discordo
    easyeffects
    element-desktop
    evince
    eza
    fastfetch
    feh
    ffmpeg-full
    fftw
    fzf
    #gadacz
    gcc
    gdb
    gnumake
    grc
    git
    helvum
    hmm
    httpie
    imagemagick
    img2pdf
    impala
    imv
    inetutils
    jrnl
    keepassxc
    lazygit
    libtool
    links2
    mapscii
    mars-mips
    moc
    ncmpcpp
    neofetch
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
    openjdk17
    pamixer
    pavucontrol
    pdfarranger
    pfetch
    pidgin
    playerctl
    polkit
    pyradio
    python3
    qbittorrent
    ripgrep
    rnote
    rustdesk
    scc
    scummvm
    sherlock
    signal-desktop-beta
    smartmontools
    telegram-desktop
    texliveFull
    tldr
    thunderbird
    tor-browser-bundle-bin
    trash-cli
    tree
    ttyper
    typst
    unzip
    util-linux
    v4l-utils
    ventoy-full
    vlc
    vscodium
    weechat
    wezterm
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
