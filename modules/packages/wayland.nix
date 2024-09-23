{
  config,
  lig,
  pkgs,
  ...
}: let
in {
  # These are packages I only need in wayland environments, nowhere else.
  environment.systemPackages = with pkgs; [
    wl-clipboard
    grimblast
  ];
}
