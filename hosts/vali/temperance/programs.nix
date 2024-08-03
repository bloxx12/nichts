{
  inputs',
  pkgs,
  ...
}: let
  nixpkgs-wayland = inputs'.nixpkgs-wayland.packages;
in {
  environment.systemPackages = with pkgs; [
    alsa-utils
    asciinema
    blanket
    calibre
    cbonsai
    coreutils-full
    cmake
    cmus
    difftastic
    dig
    element-desktop
    evince
    eza
    fastfetch
    ffmpeg-full
    fftw
    fzf
    gcc
    gdb
    gnumake
    gnutls
    grc
    grimblast
    gthumb
    git
    helvum
    heroic
    httpie
    imagemagickBig
    img2pdf
    impala
    imv
    inetutils
    jrnl
    keepassxc
    krita
    lazygit
    librewolf
    libtool
    links2
    lutris
    mapscii
    mars-mips
    moc
    musikcube
    nautilus
    ncmpcpp
    nettools
    neofetch
    nheko
    networkmanagerapplet
    nextcloud-client
    nicotine-plus
    nil
    nitch
    nixpkgs-wayland.swww
    nmap
    nodejs_20
    obsidian
    onlyoffice-bin
    pamixer
    pavucontrol
    pdfarranger
    pfetch
    playerctl
    polkit
    prismlauncher
    pulsemixer
    python3
    qbittorrent
    r2modman
    ripgrep
    rnote
    scc
    scummvm
    sherlock
    shotwell
    signal-desktop-beta
    smartmontools
    teamspeak_client
    telegram-desktop
    temurin-bin-17
    tldr
    thunderbird
    tor-browser
    trash-cli
    tree
    ttyper
    unzip
    util-linux
    v4l-utils
    vlc
    wget
    wine
    winetricks
    wireguard-tools
    wl-clipboard
    xdg-utils
    xournalpp
    yazi
    zapzap
    zip
  ];
}
