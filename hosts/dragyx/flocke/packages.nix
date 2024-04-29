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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # inputs.vivado2019flake.vivado-2019_2

    # security audits
    lynis
    element-desktop
    jetbrains.idea-community
    jetbrains.rust-rover
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
