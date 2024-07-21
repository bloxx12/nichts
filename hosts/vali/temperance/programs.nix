{
  inputs,
  pkgs,
  ...
}: let
  nixpkgs-wayland = inputs.nixpkgs-wayland.packages.${pkgs.system};
in {
  environment.systemPackages = with pkgs; [
    abaddon
    alejandra
    alsa-utils
    asciinema
    bibata-cursors
    blanket
    broot
    browsh
    cachix
    calc
    calibre
    cbonsai
    cmake
    cmus
    difftastic
    dig
    digikam
    easyeffects
    element-desktop
    evince
    eza
    fastfetch
    feh
    ffmpeg-full
    fftw
    fzf
    grimblast
    gcc
    gdb
    gnumake
    gnutls
    grc
    grimblast
    gthumb
    git
    helvum
    hmm
    heroic
    httpie
    i3lock
    imagemagick
    img2pdf
    impala
    imv
    inetutils
    jrnl
    keepassxc
    krita
    lazygit
    #librewolf
    libtool
    links2
    lutris
    mapscii
    mars-mips
    moc
    musikcube
    nautilus
    ncmpcpp
    neofetch
    nheko
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
    scc
    scummvm
    sherlock
    shotwell
    signal-desktop-beta
    smartmontools
    steam
    strawberry
    teamspeak_client
    telegram-desktop
    texliveFull
    tldr
    thunderbird
    tor-browser-bundle-bin
    trash-cli
    tree
    ttyper
    typst
    # typstfmt does not work either
    typstyle
    typst-lsp
    unzip
    util-linux
    v4l-utils
    ventoy-full
    vlc
    vscodium
    weechat
    wezterm
    wget
    wine
    winetricks
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
