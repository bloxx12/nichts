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
  };
  security.sudo.package = pkgs.sudo.override { withInsults = true; };
  security.polkit.enable = true;
  programs.kdeconnect.enable = true;
  programs.dconf.enable = true;
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];
#  services.picom.enable = true; 
  modules = {
      other = {
          system = {
              hostname = "mars";
              username = "vali";
              gitPath = "/home/vali/repos/nichts";
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
#          awesome.enable = true;
          hyprland.enable = true;
          newsboat.enable = true;
#          emacs.enable = true;
          fish.enable = true;
          stylix.enable = true;
          helix.enable = true;
          nh.enable = true;
          schizofox.enable = true;
#          spicetify.enable = true;
          anyrun.enable = true;
      };
      services = {
          pipewire.enable = true;
      };
      themes = {
          gtk = {
              enable = true;
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

