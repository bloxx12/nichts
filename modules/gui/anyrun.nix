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
                  hidePluginInfo = true;
                  closeOnClick = true;
                  showResultsImmediately = true;
                  maxEntries = 50;
                  width.fraction = 0.5;
                  y.absolute = 15;
              };
              
              extraCss = ''
                  @define-color bg-col  rgba(30, 30, 46, 0.7);
                  @define-color bg-col-light rgba(150, 220, 235, 0.7);
                  @define-color border-col rgba(30, 30, 46, 0.7);
                  @define-color selected-col rgba(150, 205, 251, 0.7);
                  @define-color fg-col #D9E0EE;
                  @define-color fg-col2 #F28FAD;

                  * {
                    transition: 200ms ease;
                    font-family: "JetBrainsMono Nerd Font";
                    font-size: 1.0rem;
                  }

                  #window {
                    background: transparent;
                  }

                  #plugin,
                  #main {
                    border: 3px solid @border-col;
                    color: @fg-col;
                    background-color: @bg-col;
                  }
                  /* anyrun's input window - Text */
                  #entry {
                    color: @fg-col;
                    background-color: @bg-col;
                  }

                  /* anyrun's ouput matches entries - Base */
                  #match {
                    color: @fg-col;
                    background: @bg-col;
                  }

                  /* anyrun's selected entry - Red */
                  #match:selected {
                    color: @fg-col2;
                    background: @selected-col;
                  }

                  #match {
                    padding: 3px;
                    border-radius: 16px;
                  }

                  #entry, #plugin:hover {
                    border-radius: 16px;
                  }

                  box#main {
                    background: rgba(30, 30, 46, 0.7);
                    border: 1px solid @border-col;
                    border-radius: 15px;
                    padding: 5px;
                  }
                '';
          };
      };
  };
}

