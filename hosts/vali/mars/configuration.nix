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
  /*
  stylix = {
      image = ./2024-04-21-14-50.png;
      polarity = "dark";
      autoEnable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-soft.yaml";
      opacity = {
          applications = 0.9;
          popups = 0.9;
          desktop = 0.9;
      };
      targets = {
          fish.enable = true;
          grub.enable = true;
          gtk.enable = true;
          nixos-icons.enable = true;
          plymouth.enable = true;
          #emacs.enable = true;
          firefox.enable = true;
          kitty.enable = true;
          lazygit.enable = true;
          rofi.enable = true;
          tmux.enable = true;
          vim.enable = true;
          zathura.enable = true;
      };
      fonts = {
          sizes = {
              terminal = 14;
          };
          sansSerif = {
              package = pkgs.dejavu_fonts;
              name = "DejaVu Sans";
          };
          monospace = {
              package = (pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];});
              name = "JetBrainsMono";
          };
          emoji = {
              package = pkgs.noto-fonts-emoji;
              name = "Noto Color Emoji";
          };
      };
      cursor = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Classic";
          size = 24;
        };
  };
  */

  security.sudo.package = pkgs.sudo.override { withInsults = true; };
  security.polkit.enable = true;
  programs.kdeconnect.enable = true;
  programs.dconf.enable = true;
 services.picom.enable = true; 
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
          hyprland.enable = true;
          newsboat.enable = true;
          emacs.enable = true;
          fish.enable = true;
          stylix.enable = true;
          anyrun.enable = true;
      };
      services = {
          pipewire.enable = true;
      };
      themes = {
          cursor = {
              enable = false;
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
            enable = false;
            package = pkgs.kde-gruvbox;
            name = "Gruvbox-Dark";
          };
      };
    };
  system.stateVersion = "23.11";
}

