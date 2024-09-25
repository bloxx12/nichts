{pkgs, ...}: {
  imports = [
    ./hardware.nix
    ./wayland.nix
    # ./media.nix
  ];
  # These are some standard packages I want to have installed on every system, regardless of type or use case.
  environment.systemPackages = with pkgs; [
    calc # Calculator device
    coreutils-full # All of the GNU coreutils
    curl # I sometimes need to curl stuff
    git # take a guess
    inetutils # internet stuff I need/want on every system.
    wget
    unzip # zipping and unzipping stuff
    zip
    util-linux
  ];
}
