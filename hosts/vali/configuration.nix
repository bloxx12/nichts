{ config, inputs, pkgs, ... }:
{
  time.timeZone = "Europe/Zurich";
  security.sudo.package = pkgs.sudo.override { withInsults = true; };
  security.polkit.enable = true;
  programs.kdeconnect.enable = true;
  myOptions = {
      other = {
          system = {
              hostname = "nixos";
              username = "vali";
          };
          home-manager = {
              enable = true;
          };
      };
      programs = {
          vesktop.enable = true;
          btop.enable = true;
          mpv.enable = true;
          neovim.enable = true;
          pipewire.enable = true;
          git = {
              enable = true;
              userName = "vali";
              userEmail = "valentin@kaas.cc";
              defaultBranch = "master";
          };
          starship.enable = true;
          zsh = {
              enable = true;
              profiling = false;
          };
         i3 = {

          };
      };
      themes = {
          cursor = {
              enable = true;
              package = pkgs.bibabta.cursors;
              name = "Bibata-Modern-Classic";
              size = "24";
          };
          gtk = {
              enable = true;
              package = pkgs.catppuccin-gtk;
              name = "Catppuccin-Mocha-Standard-Green-Dark";
              variant = "mocha";
              accentColour = "green";
              iconTtheme = {
                  name = "Papirus-Dark";
                  package = pkgs.catppuccin-papirus-foldersM
              };
          };
          qt = {
            enable = true;
            package = pkgs.catppuccin-kde;
            name = "Catppuccin-Mocha-Dark"
            variant = "mocha";
            accentColour = "green";
          };
      };
    };
  system.stateVersion = "23.11";
}
