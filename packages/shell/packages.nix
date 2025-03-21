pkgs:
builtins.attrValues {
  inherit
    (pkgs)
    # better cd
    zoxide
    #better ls
    eza
    atuin
    # better cat
    bat
    # clipboard
    # yazi
    serpl
    diff-so-fancy
    tig
    direnv
    sesh
    mprocs
    curlie
    entr
    procs
    sd
    # mult
    glow
    # dua-cli
    dust
    kondo
    # better grep
    ripgrep
    # better dig
    dogdns
    # simply the best fetch tool out there
    microfetch
    fzf
    element
    carapace
    difftastic
    hexyl
    iputils
    gnumake
    gping
    asciinema
    inetutils
    scc
    starship
    onefetch
    wget
    cpufetch
    yt-dlp
    tealdeer
    hyperfine
    imagemagick
    ffmpeg-full
    # catimg
    timg
    nmap
    fd
    jq
    rsync
    figlet
    unzip
    zip
    ;
}
