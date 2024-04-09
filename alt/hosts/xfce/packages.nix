{ inputs, outputs, pkgs, profile-config, ... }:

{
  environment.systemPackages = with pkgs; [
    jetbrains.idea-community
    ani-cli
    okular
    texliveFull
    signal-desktop
    nextcloud-client
    vlc
    strawberry
    telegram-desktop
    betterbird
    vesktop
    zsh
    zoxide
    eza
    mpv
    librewolf
    keepassxc
    feh 
    libreoffice
    openjdk

  ];
}
