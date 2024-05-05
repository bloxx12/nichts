{ config, pkgs, lib, inputs, ... }: 

with lib;
let 
  username = config.modules.other.system.username;
  cfg = config.modules.programs.anyrun;
in {
  options.modules.programs.anyrun.enable = mkEnableOption "anyrun";
  config = mkIf cfg.enable {
      home-manager.users.${username} = {
          imports = [ inputs.anyrun.homeManagerModules.default ];
          
          programs.anyrun = {
              enable = true;
              config = {
                  plugins = with inputs.anyrun.packages.${pkgs.system}; [
                      applications
                      dictionary
                      kidex
                      rink
                      symbols
                      translate
                  ];
                  hideIcons = false;
                  ignoreExclusiveZones = false;
                  layer = "overlay";
                  hidePluginInfo = false;
                  closeOnClick = true;
                  showResultsImmediately = true;
                  maxEntries = 50;
                  width.fraction = 0.3;
                  y.absolute = 15;
              };
          };
      };
  };
}

