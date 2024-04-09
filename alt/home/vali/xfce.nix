{ inputs, outputs, pkgs, user, ... }:

{
  imports = [
    # Would look like this: 
    # ../../terminal/zsh/home.nix 
    inputs.schizofox.homeManagerModule
    ../../modules/web/schizofox.nix
    #../../modules/terminal/zsh/home.nix
  ];
  xdg.configHome = "/home/${user}/.config/";
  programs.home-manager.enable = true;
  home = {
      stateVersion = "23.11";
      username = "${user}";
      homeDirectory = "/home/${user}";
    };
}
