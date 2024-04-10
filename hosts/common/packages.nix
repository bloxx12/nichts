{ inputs, outputs, profile-config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    neovim
    eza
    zsh
    git
    zip
    unzip
    neofetch
    fastfetch
    wget
    zoxide
    python3
    gcc
    htop
    networkmanager
    uwufetch
  ];    
}
