{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    alsa-utils
    asciinema
    cachix
    calc
    # calibre
    cbonsai
    cmus
    difftastic
    element
    element-desktop
    evince
    eza
    firefox
    fftw
    grc
    gparted
    git
    halloy
    helvum
    httpie
    hyperfine
    imagemagick
    img2pdf
    impala
    imv
    inetutils
    jujutsu
    jrnl
    keepassxc
    lazygit
    libtool
    librewolf
    links2
    mapscii
    moc
    ncmpcpp
    neofetch
    networkmanagerapplet
    nextcloud-client
    nicotine-plus
    nil
    nitch
    swww
    microfetch
    nmap
    notesnook
    pamixer
    pavucontrol
    pdfarranger
    pfetch
    pidgin
    playerctl
    polkit
    python3
    ripgrep
    signal-desktop-beta
    smartmontools
    telegram-desktop
    texliveFull
    tldr
    thunderbird
    tor-browser
    trash-cli
    typst
    util-linux
    v4l-utils
    vesktop
    vlc
    weechat
    wireguard-tools
    xournalpp
    zapzap
    zip
    zoxide
  ];
}
