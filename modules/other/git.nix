{
  pkgs,
  config,
  ...
}: let
  inherit (config.modules.other.system) username;
in {
  programs.git = {
    enable = true;
    lfs.enable = true;
    config = {
      user = {
        name = "Charlie Root";
        email = "charlie@charlieroot.dev";
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILPiRe9OH/VtWFWyy5QbAVcN7CLxr4zUtRCwmxD6aeN6";
      };
      init.defaultbranch = "main";
      branch.autosetupmerge = "true";
      merge.stat = "true";
      pull.ff = "only";
      gpg.format = "ssh";
      commit.gpgsign = "true";
      rebase = {
        autoSquash = true;
        autoStash = true;
      };
      rerere = {
        enabled = true;
        autoupdate = true;
      };
    };
  };
}
