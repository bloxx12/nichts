{pkgs, ...}: {
  environment.systemPackages = builtins.attrValues {
    inherit
      (pkgs)
      alsa-utils
      anki
      asciinema
      beets
      cachix
      calc
      cinny-desktop
      difftastic
      dnsutils
      element-desktop
      evince
      gcc
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
      joplin-desktop
      jujutsu
      julia
      just
      keepassxc
      lazygit
      librewolf
      libtool
      logiops
      mpv
      nextcloud-client
      nheko
      nicotine-plus
      swww
      pandoc
      pavucontrol
      pdfarranger
      picard
      polkit
      pulsemixer
      python3
      pwvucontrol
      qbittorrent
      r2modman
      radare2
      ripgrep
      rmpc
      signal-desktop
      strawberry
      telegram-desktop
      texliveFull
      thunderbird
      tor-browser
      trash-cli
      tutanota-desktop
      typst
      walker
      wayneko
      wireguard-tools
      xdg-utils
      xournalpp
      zapzap
      zathura
      zotero
      zoxide
      ;
  };
}
