{pkgs, ...}: let

key =
pkgs.writeText "signingkey"  "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAAWEDj/Yib6Mqs016jx7rtecWpytwfVl28eoHtPYCM9TVLq81VIHJSN37lbkc/JjiXCdIJy2Ta3A3CVV5k3Z37NbgAu23oKA2OcHQNaRTLtqWlcBf9fk9suOkP1A3NzAqzivFpBnZm3ytaXwU8LBJqxOtNqZcFVruO6fZxJtg2uE34mAw==";
in{
  programs.git = {
    enable = true;
    lfs.enable = true;
    config = {
      user = {
        name = "Charlie Root";
        email = "charlie@charlieroot.dev";
        signingKey = "${key}";
      };
      init.defaultbranch = "main";
      branch.autosetupmerge = "true";
      merge.stat = "true";
      pull.ff = "only";
      gpg.format = "ssh";
      commit.gpgsign = "true";
      # breaks forgejo
      # diff.external = "${pkgs.difftastic}/bin/difft";

      signing = {
        key = "${key}";
        signByDefault = true;
      };
      core = {
        editor = "hx";
      };
      rebase = {
        autoSquash = true;
        autoStash = true;
      };
      rerere = {
        enabled = true;
        autoupdate = true;
      };
      feauture = {
        manyFiles = true;
      };
    };
  };
}
