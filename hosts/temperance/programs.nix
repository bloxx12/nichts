{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # FIXME: temporary
    # libayatana-appindicator-gtk3
    libayatana-appindicator
    alsa-utils
    asciinema
    bottles
    cachix
    calc
    calibre
    difftastic
    element-desktop
    evince
    eza
    halloy
    helvum
    httpie
    imagemagick
    img2pdf
    impala
    imv
    inetutils
    keepassxc
    lazygit
    libtool
    lutris
    nextcloud-client
    nicotine-plus
    swww
    microfetch
    nmap
    # onlyoffice-bin
    pavucontrol
    pdfarranger
    polkit
    pulsemixer
    python3
    pwvucontrol
    qbittorrent
    r2modman
    ripgrep
    signal-desktop-beta
    telegram-desktop
    thunderbird
    tor-browser
    trash-cli
    tutanota-desktop
    typst
    wireguard-tools
    xdg-utils
    xournalpp
    zapzap
    zoxide
  ];
}
