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
            #rink
            shell
            #   symbols
            #translate
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
            )
          '';
          "websearch.ron".text = ''
            Config(
                prefix: "?",
                engines: [DuckDuckGo]
            )
          '';

          "symbols.ron".text = ''
            Config(
              // The prefix that the search needs to begin with to yield symbol results
              prefix: ":sy",

              // Custom user defined symbols to be included along the unicode symbols
              symbols: {
                // "name": "text to be copied"
                "shrug": "¯\\_(ツ)_/¯",
              },

              // The number of entries to be displayed
              max_entries: 5,
            )
          '';

          "translate.ron".text = ''
            Config(
              prefix: ":tr",
              language_delimiter: ">",
              max_entries: 3,
            )
          '';
        };
      };
    };
  };
}
