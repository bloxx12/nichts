{
  pkgs,
  aliasesStr,
}:
pkgs.writeShellScriptBin "config.fish" ''

  # source ${pkgs.fishPlugins.sponge}/share/zsh-defer/zsh-defer.plugin.zsh
  ${pkgs.atuin}/bin/atuin init fish | source
  ${pkgs.zoxide}/bin/zoxide init fish | source


  source ${./config.fish}


  ${aliasesStr}
''
