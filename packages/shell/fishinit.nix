{
  pkgs,
  aliasesStr,
}:
pkgs.writeText "config.fish" ''

  # source ${pkgs.fishPlugins.sponge}/share/zsh-defer/zsh-defer.plugin.zsh
  ${pkgs.atuin}/bin/atuin init fish | source
  ${pkgs.zoxide}/bin/zoxide init fish | source
  ${pkgs.starship}/bin/starship init fish | source
  ${pkgs.direnv}/bin/direnv hook fish | source
  ${pkgs.pay-respects}/bin/pay-respects fish --alias f --nocnf | source


  source ${./config.fish}


  ${aliasesStr}
''
