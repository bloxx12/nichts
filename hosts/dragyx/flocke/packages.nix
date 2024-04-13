# which default packages to use for the system
{ inputs, outputs, profile-config, pkgs, ...}:

let 
  python-packages = ps: with ps; [
    pandas
    numpy
    opencv4
    ipython
  ];
in
{

  imports = [
    ../common/packages.nix
  ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # security audits
    lynis
    element-desktop
    jetbrains.idea-community
    baobab
    amdvlk
    texlive.combined.scheme-full 
    android-tools
    signal-desktop
    nextcloud-client
    # etcher
    vlc
    audacity
    thunderbird
    eclipses.eclipse-java
    openjdk
    firefox
    # pkgs.nordvpn # nur.repos.LuisChDev.nordvpn
    material-icons
    material-design-icons
    libreoffice
    gimp
    spotify
    okular
    # minecraft
    prismlauncher-unwrapped
    glfw-wayland-minecraft
    glxinfo
    # window manager
    flameshot
    feh
    # Animeeeeee!
    ani-cli # The stable version is very outdated
  ];

}
