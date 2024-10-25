{
  pkgs,
  aliasesStr,
}:
pkgs.writeShellScriptBin "config.fish" ''

  # source ${pkgs.fishPlugins.sponge}/share/zsh-defer/zsh-defer.plugin.zsh
  ${pkgs.atuin}/bin/atuin init fish | source
  ${pkgs.zoxide}/bin/zoxide init fish | source

  source ${./starship.fish}
  source ${./zoxide.fish}

  source ${./config.fish}

  zsh-defer source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh
  zsh-defer source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh
  zsh-defer source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
  zsh-defer source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
  zsh-defer source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  zsh-defer source ${pkgs.zsh-autopair}/share/zsh/zsh-autopair/autopair.zsh


  ${aliasesStr}
''
