{
  inputs',
  pkgs,
  ...
}: let
  inherit (inputs'.nixpkgs-stable.legacyPackages) calibre;
in {
  environment.systemPackages = with pkgs;
    [
      alsa-utils
      anki
      asciinema
      cachix
      calc
      difftastic
      element-desktop
      evince
      eza
      gcc
      gnumake
      halloy
      helvum
      httpie
      imagemagick
      img2pdf
      impala
      imv
      inetutils
      jujutsu
      keepassxc
      lazygit
      libtool
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
      ripgrep
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
    ]
    ++ [calibre];
}
