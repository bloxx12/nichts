{ config, inputs, pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfree = true;
  # Time Zone 
  time.timeZone = "Europe/Zurich";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "de";
    # enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # reduce file size used & automatic garbage collector
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 14d";
  };
  # required for nix-direnv to work and have environments not garbage collected
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';
  security.sudo.package = pkgs.sudo.override { withInsults = true; };
  security.polkit.enable = true;
  programs.kdeconnect.enable = true;
  programs.neovim.defaultEditor = true;
  programs.adb.enable = true;
  services.mpd = {
      enable = true;
      musicDirectory = "/home/vali/Nextcloud/Media/Music/";
      startWhenNeeded = true;
      extraConfig = ''
          audio_output {
          type "pipewire"
          name "My PipeWire Output"
          }       
      '';
  };

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
          dwm.enable = true;
          awesome.enable = true;
          newsboat.enable = true;
          #git = {
          #    enable = true;
          #    userName = "vali"; userEmail = "valentin@kaas.cc";
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
              enable = false;
              package = pkgs.gruvbox-gtk-theme;
              name = "Gruvbox-Dark-BL";
              iconTheme = {
                 # name = "Papirus-Dark";
                 # package = pkgs.catppuccin-papirus-folders;
              };
          };
          qt = {
            enable = true;
            package = pkgs.kde-gruvbox;
            name = "Gruvbox";
          };
      };
    };
  system.stateVersion = "23.11";
}

