{ inputs, outputs, profile-config, pkgs, ... }:

{
  imports = [
  #profile-config.overlays
  inputs.home-manager.nixosModules.home-manager
  ./packages.nix
  ];

  services.locate = {
      enable = true;
      interval = "daily";
      package = pkgs.plocate;
      localuser = null;
  };
  
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users = builtins.listToAttrs (builtins.map(
    u-conf: {
        inherit inputs;
        name = u-conf.name;
        value = import u-conf.config { inherit pkgs inputs outputs; user = u-conf.name; };
      }
  )profile-config.user-configs);

  users.users = builtins.listToAttrs (builtins.map(
    u-conf: {
        name = u-conf.name;
        value = {
            initialPassword = "${u-conf.name}";
            isNormalUser = true;
            extraGroups = [ "wheel" "audio" "video" "input"];
          };
      }
  )profile-config.user-configs);

   time.timeZone = "Europe/Zurich";
   i18n.defaultLocale = "en_US.UTF-8";
   documentation.nixos.enable = false;
  # Set the keyboard layout to german
  # Eable CUPS
  services.printing.enable = true;
  # Sound settings
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
      enable = true;
      alsa.enable = true;
      jack.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
      alsa.support32Bit = true;
    };
  nix = {
      package = pkgs.nixFlakes;
      extraOptions = "experimental-features = nix-command flakes";
    };
  system.stateVersion = "23.11";
}
