{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.modules.other.system) username;
in {
  config.home-manager.users.${username}.programs.kakoune.config.keyMappings = [
    {
      mode = "normal";
      key = "<esc>";
      effect = ";,";
      docstring = "Press escape to clear highlighted text and collapse cursors";
    }
    {
      mode = "normal";
      key = "<c-v>";
      effect = ":comment-line<ret>";
      docstring = "Comment a line with <c-v>!";
    }
    {
      mode = "normal";
      key = "b";
      effect = ":db<ret>";
      docstring = "close current buffer";
    }

    {
      mode = "normal";
      key = "n";
      effect = ":bp<ret>";
      docstring = "go to next buffer";
    }
    {
      mode = "normal";
      key = "m";
      effect = ":bn<ret>";
      docstring = "go to next buffer";
    }
    {
      mode = "normal";
      key = " f";
      effect = ":fzf-mode<ret>";
      docstring = "open fzf";
    }
  ];
}
