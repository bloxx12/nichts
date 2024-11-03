{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    alsa-utils
    anki
    asciinema
    cachix
    calc
    calibre
    difftastic
    distrobox
    element-desktop
    evince
    eza
    gcc
    ghidra
    ida-free
    gnumake
    halloy
    helvum
    httpie
    imagemagick
    imhex
    img2pdf
    impala
    imv
    inetutils
    jujutsu
    keepassxc
    lazygit
    libtool
    mpv
    nextcloud-client
    nicotine-plus
    swww
    microfetch
    nmap
    nyxt
    # onlyoffice-bin
    pandoc
    pavucontrol
    pdfarranger
    polkit
    pulsemixer
    python3
    pwvucontrol
    qbittorrent
    r2modman
    radare2
    ripgrep
    rmpc
    signal-desktop-beta
    strawberry
    telegram-desktop
    texliveFull
    thunderbird
    tor-browser
    trash-cli
    tutanota-desktop
    typst
    ungoogled-chromium
    wineWowPackages.waylandFull
    wireguard-tools
    xdg-utils
    xournalpp
    zapzap
    zoxide
  ];
}
