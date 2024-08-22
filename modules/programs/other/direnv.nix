_: {
  programs.direnv = {
    enable = true;
    # PLEASE BE SILENT
    silent = true;

    # We want direnv to load in our nix dev shells
    loadInNixShell = true;

    # Integrations for all our shells
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };
}
