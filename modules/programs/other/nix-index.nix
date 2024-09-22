{pkgs, ...}: {
  programs = {
    # We have to disable this and use nix-index instead. (Rust >>> Pearl)
    command-not-found = {
      enable = false;
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
