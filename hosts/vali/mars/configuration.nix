{ config, inputs, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  time.timeZone = "Europe/Zurich";
  console.keyMap = "de";
  security.sudo.package = pkgs.sudo.override { withInsults = true; };
  security.polkit.enable = true;
  programs.kdeconnect.enable = true;
  myOptions = {
      other = {
          system = {
              hostname = "mars";
              username = "vali";
              gitPath = "/home/vali/Git/nichts";
          };
          home-manager = {
              enable = true;
              enableDirenv = true;
          };
      };
      programs = {
          vesktop.enable = true;
          btop.enable = true;
          mpv.enable = true;
          i3.enable = true;
          awesome.enable = true;
          schizofox.enable = true;
          obs.enable = true;
          displaymanager.enable = true;
          #neovim.enable = true;
          #git = {
          #    enable = true;
          #    userName = "vali";
          #    userEmail = "valentin@kaas.cc";
          #    defaultBranch = "main";
          #};
          starship.enable = true;
          zsh = {
              enable = true;
              profiling = false;
          };
      };
      services = {
          pipewire.enable = true;
        };
      themes = {
          cursor = {
              enable = true;
              package = pkgs.bibata-cursors;
              name = "Bibata-Modern-Classic";
              size = 24;
          };
          gtk = {
              enable = true;
              package = pkgs.catppuccin-gtk;
              name = "Catppuccin-Mocha-Standard-Green-Dark";
              variant = "mocha";
              accentColour = "green";
              iconTheme = {
                  name = "Papirus-Dark";
                  package = pkgs.catppuccin-papirus-folders;
              };
          };
          qt = {
            enable = true;
            package = pkgs.catppuccin-kde;
            name = "Catppuccin-Mocha-Dark";
            variant = "mocha";
            accentColour = "green";
          };
      };
    };
  system.stateVersion = "23.11";
}
