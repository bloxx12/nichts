{ config, lib, inputs, pkgs, ... }:
with lib; let
  username = config.modules.other.system.username;
  cfg = config.modules.programs.firefox;
in {
    options.modules.programs.firefox = {
      enable = mkEnableOption "firefox";
      extensions = mkOption {
        description = "firefox extensions (format like https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265)";
	type = types.attrs;
	default = {};
      };
    };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.firefox = {
        enable = true;
	policies = {
	  ExtensionSettings = lib.mkMerge [{
	    "uBlock0@raymondhill.net" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
              installation_mode = "force_installed";
            };
	  } cfg.extensions];
	};
      };
    };
  };
}
