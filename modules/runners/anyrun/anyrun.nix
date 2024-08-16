{
  config,
  lib,
  inputs,
  inputs',
  ...
}: let
  inherit (config.modules.other.system) username;
  cfg = config.modules.usrEnv.programs.launchers.anyrun;
  inherit (lib) mkIf;
in {
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      imports = [inputs.anyrun.homeManagerModules.default];

      programs.anyrun = {
        enable = true;
        config = {
          plugins = with inputs'.anyrun.packages; [
            applications
            dictionary
            shell
            websearch
          ];
          hideIcons = false;
          ignoreExclusiveZones = false;
          layer = "overlay";
          hidePluginInfo = true;
          closeOnClick = true;
          showResultsImmediately = true;
          maxEntries = 10;
          width.fraction = 0.3;
          y.absolute = 15;
        };
        extraCss = builtins.readFile ./style.css;

        extraConfigFiles = {
          "applications.ron".text = ''
            Config(
                max_entries: 10,
                terminal: Some("foot"),
                desktop_actions: false
            )
          '';

          "websearch.ron".text = ''
            Config(
                prefix: "?",
                engines: [DuckDuckGo]
            )
          '';
        };
      };
    };
  };
}
