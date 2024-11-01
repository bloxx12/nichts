{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.modules.programs.btop;

  btop-settings = pkgs.writeTextDir "btop/btop.conf" ''
    truecolor = True
    vim_keys = True
    rounded_corners = True
    update_ms = 100
    graph_symbol = "braille"
    cpu_single_graph = True
    clock_format = "%X"
    use_fstab = True
    io_mode = True
    net_sync = True
    net_iface = "enp4s0"
    log_level = "ERROR"
  '';

  btop-wrapped = pkgs.symlinkJoin {
    name = "btop-wrapped";
    paths = [pkgs.btop];
    buildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/btop --set XDG_CONFIG_HOME "${btop-settings}"
    '';
  };
in {
  options.modules.programs.btop.enable = mkEnableOption "btop";
  config = mkIf cfg.enable {
    environment.systemPackages = [btop-wrapped];
  };
}
