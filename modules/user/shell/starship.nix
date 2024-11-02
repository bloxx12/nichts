{
  add_newline = false;
  command_timeout = 2000;
  format = "$hostname$username$directory$shell$nix_shell$git_branch$git_commit$git_state$git_status$jobs$cmd_duration\n$character";
  scan_timeout = 2;

  character = {
    error_symbol = "[](bold red)";
    format = "$symbol [|](bold bright-black) ";
    success_symbol = "[](bold green)";
    vicmd_symbol = "[](bold yellow)";
  };
  directory = {
    format = "[ ](bold green) [$path]($style) ";
    truncation_length = 2;
  };
  git_branch = {
    style = "bold purple";
  };

  git_commit.commit_hash_length = 7;

  git_status = {
    ahead = "⇡ ";
    behind = "⇣ ";
    conflicted = " ";
    deleted = "✘ ";
    diverged = "⇆ ";
    modified = "!";
    renamed = "»";
    staged = "+";
    stashed = "≡";
    style = "red";
    untracked = "?";
  };

  golang.symbol = "[󰟓 ](blue)";
  hostname = {
    disabled = false;
    format = "@[$hostname](bold blue) ";
    ssh_only = true;
  };

  line_break.disabled = false;

  c.symbol = "[ ](black)";
  lua.symbol = "[ ](blue) ";

  nix_shell.symbol = "[󱄅 ](blue) ";

  nodejs.symbol = "[󰎙 ](yellow)";

  package.symbol = "📦 ";

  python.symbol = "[ ](blue) ";

  rust.symbol = "[ ](red) ";

  username.format = "[$user]($style) in ";
}
