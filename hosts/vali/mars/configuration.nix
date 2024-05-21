{ pkgs, ... }: {
  # allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # Time Zone 
  time.timeZone = "Europe/Zurich";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "de";
  nix = {
    settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
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
  # boot.kernelModules = [ "v4l2loopback" ];
  boot.kernelPackages = pkgs.linuxPackages_zen;
  # boot.extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];
  #  services.picom.enable = true; 
  services.emacs.enable = true;
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
    wms = {
      wayland = {
        enable = true;
        hyprland.enable = true;
      };
    };
    programs = {
      vesktop.enable = true;
      ssh.enable = true;
      btop.enable = true;
      mpv.enable = true;
      kitty.enable = true;
      newsboat.enable = true;
      foot.enable = true;
      fish.enable = true;
      stylix.enable = true;
      nh.enable = true;
      waybar.enable = true;
      spicetify.enable = true;
      schizofox.enable = true;
      anyrun.enable = true;
    };
    editors = {
      emacs = {
        enable = false;
        doom.enable =  false;
      };
      helix.enable = true;
      kakoune.enable = true;
    };
    services = {
      pipewire.enable = true;
      dunst.enable = true;
    };
    themes = {
      gtk = { enable = true; };
      qt = {
        enable = false;
        package = pkgs.kde-gruvbox;
        name = "Gruvbox-Dark";
      };
    };
  };
  system.stateVersion = "23.11";
}
