{pkgs, ...}: {
  programs = {
    command-not-found = {
      # TODO fix this
      enable = false;
      dbPath = pkgs.sqlite;
    };
    nix-index = {
      enable = true;
      package = pkgs.nix-index;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };
  };
}
