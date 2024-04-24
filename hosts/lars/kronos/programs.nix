{ config, lib, pkgs, ... }:

let
    newer_egl-wayland = self: super: {
      egl-wayland = super.xwayland.overrideAttrs (prev: {
        # version = "23.2.6-HEAD";
        src = pkgs.fetchFromGitHab {
          # domain = "gitlab.freedesktop.org";
          owner = "NVIDIA";
          repo = "egl-wayland";
          rev = "067e43d0d4af82e4ea3fdc8ce476e6a24f69956f";
          sha256 = "93DzgA8nXVodDvllCOIuTtOYWpUdXwzPIGpi2SUSNqo=";
        };
      });
    };
in
{
  environment.systemPackages = with pkgs; [
    egl-wayland
  ];
}
