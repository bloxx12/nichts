{config, ...}: let
  inherit (config.modules.style.cursor) package name size;
  inherit (config.modules.other.system) username;
in {
  imports = [
    ./qt.nix
    # ./gtk.nix
    ./colors.nix
    ./fonts.nix
  ];
  # home-manager.users.${username} = {
  #   home.pointerCursor = {
  #     # inherit the default values set in the options,
  #     # since these are the once I need on all my systems.
  #     inherit package name size;

  #     # make gtk follow the cursor choices
  #     # gtk.enable = true;

  #     # ditto
  #     x11.enable = true;
  #   };
  # };
}
