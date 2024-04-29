# which default packages to use for the system
{ inputs, outputs, profile-config, pkgs, ...}:

let 
  python-packages = ps: with ps; [
    pandas
    numpy
    opencv4
    ipython
  ];
in
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    (python3.withPackages python-packages)
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neovim
    eza # exa is unmaintained
    hwinfo
    zsh
    git
    broot
    unzip
    rsync
    # neofetch 
    # fastfetch has the option to set a timeout for
    #   for each module, which makes it dramatically faster
    #   as counting the number of packages takes over 800 (!!!) ms,
    #   which makes it very unpleasant to use as default thing
    #   to display when starting a terminal
    zathura
    fastfetch    
    wlr-randr
    alacritty
    wget
    gnumake
    zoxide
    python3
    nodejs
    gcc
    cargo
    rustc
    rust-analyzer
    clippy
    lsof
    htop 
    okular
    smartmontools
    networkmanager
    pkg-config
    sof-firmware # audio
    nix-index
    # --------- optional
    gnome.eog
    sherlock
    xfce.thunar

    plocate
    alsa-utils

    # partition management
    parted
    gnufdisk
    lapce
  ];
}
