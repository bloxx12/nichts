# This is for packages I want in all systems.
# Keeping this list as small as possible is important,
# since these also get installed to server,
# which should have a small attack surface.
{
  self,
  pkgs,
  ...
}: let
  inherit (self.packages.${pkgs.stdenv.system}) helix fish;
in {
  environment.systemPackages = builtins.attrValues {
    inherit
      (pkgs)
      cachix
      calc
      difftastic
      eza
      gcc
      git
      httpie
      inetutils
      jujutsu
      just
      lazygit
      links2
      linuxHeaders
      neofetch
      microfetch
      nmap
      polkit
      ripgrep
      smartmontools
      trash-cli
      util-linux
      wireguard-tools
      zip
      zoxide
      ;
    inherit helix fish;
  };
  # helix as the only editor, a reasonable choice.
  environment.sessionVariables.EDITOR = pkgs.lib.getExe' helix "hx";


  
}
