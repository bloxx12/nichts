{ pkgs, inputs, config, ... }: {

  programs.niri = {
    enable = true;
    package = inputs.niri.packages.${pkgs.system}.niri-unstable;
  };
  services = {
    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${config.programs.niri.package}/bin/niri-session";
          user = "vali";
        };
        default_session = initial_session;
      };
    };

    gnome = {
      # glib-networking.enable = true;
    };

    # lorri.enable = true;
    # udisks2.enable = true;
    # printing.enable = true;
    # fstrim.enable = true;
  };
}
