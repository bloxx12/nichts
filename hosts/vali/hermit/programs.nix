{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    alejandra
    alsa-utils
    asciinema
    bibata-cursors
    blueman
    bluetuith
    bluez
    #botany
    cachix
    calc
    calibre
    cbonsai
    cmake
    cmus
    difftastic
    dig
    # easyeffects #broken
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
    hyperfine
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
    #nheko
    nicotine-plus
    nil
    nitch
    swww
    microfetch
    nmap
    notesnook
    onlyoffice-bin
    pamixer
    pavucontrol
    pdfarranger
    pfetch
    pidgin
    playerctl
    polkit
    python3
    ripgrep
    scc
    sherlock
    signal-desktop-beta
    smartmontools
    telegram-desktop
    tldr
    thunderbird
    trash-cli
    tree
    ttyper
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
