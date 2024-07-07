{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib; let
  inherit (config.modules.other.system) username;
  cfg = config.modules.programs.anyrun;
in {
  options.modules.programs.anyrun.enable = mkEnableOption "anyrun";
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      imports = [inputs.anyrun.homeManagerModules.default];

      programs.anyrun = {
        enable = true;
        config = {
          plugins = with inputs.anyrun.packages.${pkgs.system}; [
            applications
            dictionary
            #   kidex
            rink
            shell
            #   symbols
            translate
            websearch
          ];
          hideIcons = false;
          ignoreExclusiveZones = false;
          layer = "overlay";
          hidePluginInfo = true;
          closeOnClick = true;
          showResultsImmediately = true;
          maxEntries = 50;
          width.fraction = 0.3;
          y.absolute = 15;
        };
        extraCss = builtins.readFile (./. + "/style.css");

        extraConfigFiles."applications.ron".text = ''
          Config(
              desktop_actions: false,
              max_entries: 5,
              terminal: Some("foot"),
          )
        '';
        extraConfigFiles."websearch.ron".text = ''
          Config(
              prefix: "?",
              engines: [DuckDuckGo]
          )
        '';
      };
    };
  };
}
