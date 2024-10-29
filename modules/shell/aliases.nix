{pkgs, ...}: let
  inherit (pkgs.lib) getExe;
in {
  ls = "${getExe pkgs.eza} --icons";
  la = "${getExe pkgs.eza} --icons -lha --git";

  g = "git";
  n = "nix";
  k = "kak";

  c = "clear";
  cc = "cd ~ && clear";
  mv = "mv -iv";
  rm = "${pkgs.trash-cli}/bin/trash";
  lg = "${getExe pkgs.lazygit}";

  ytopus = "yt-dlp -x --embed-metadata --audio-quality 0 --audio-format opus --embed-metadata --embed-thumbnail";

  cat = "${getExe pkgs.bat} --plain";

  kys = "shutdown now";
}
