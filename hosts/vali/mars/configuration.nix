{ config, inputs, pkgs, lib, ... }:
{
  # allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # Time Zone 
  time.timeZone = "Europe/Zurich";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "de";
  nix = {
      settings = {
          # enable flakes
          experimental-features = [ "nix-command" "flakes" ];
          # reduce file size used & automatic garbage collector
          auto-optimise-store = true;
      };
      gc = {
          automatic = true;
          options = "--delete-older-than 14d";
      };
      # required for nix-direnv to work and have environments not garbage collected
      extraOptions = ''
          keep-outputs = true
          keep-derivations = true
      '';
  };

  security.sudo.package = pkgs.sudo.override { withInsults = true; };
  security.polkit.enable = true;
  programs.kdeconnect.enable = true;
  programs.dconf.enable = true;
  modules = {
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
          ssh.enable = true;
          btop.enable = true;
          mpv.enable = true;
          kitty.enable = true;
          awesome.enable = true;
          newsboat.enable = true;
          emacs.enable = true;
          fish.enable = true;
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
              enable = false;
              package = pkgs.materia-theme;
              name = "Materia-dark";
            #  iconTheme = {
            #      name = "Papirus-Dark";
            #      package = pkgs.catppuccin-papirus-folders;
            #  };
          };
          qt = {
            enable = true;
            package = pkgs.kde-gruvbox;
            name = "Gruvbox-Dark";
          };
      };
    };
  system.stateVersion = "23.11";
}

