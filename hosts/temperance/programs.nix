{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # FIXME: temporary
    # libayatana-appindicator-gtk3
    libayatana-appindicator
    alsa-utils
    asciinema
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
    hyperfine
    imagemagick
    img2pdf
    impala
    imv
    inetutils
    keepassxc
    lazygit
    libtool
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
    wireguard-tools
    xdg-utils
    xournalpp
    zapzap
    zoxide
  ];
}
