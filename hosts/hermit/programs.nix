{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    alsa-utils
    anki
    asciinema
    cachix
    calc
    # calibre
    cbonsai
    cmus
    difftastic
    element
    element-desktop
    emacs30-pgtk
    evince
    eza
    firefox
    fftw
    gcc
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
    just
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
    pamixer
    pavucontrol
    pdfarranger
    pfetch
    pidgin
    playerctl
    polkit
    python3
    ripgrep
    rmpc
    signal-desktop
    smartmontools
    taskwarrior3
    taskwarrior-tui
    telegram-desktop
    texliveFull
    tldr
    thunderbird
    tor-browser
    trash-cli
    typst
    ungoogled-chromium
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
