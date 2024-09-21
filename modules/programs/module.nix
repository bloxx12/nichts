{pkgs, ...}: {
  programs.command-not-found = {
    enable = true;
    dbPath = pkgs.sqlite;
  };
}
