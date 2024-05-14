{ config, lib, inputs, pkgs, ... }:
with lib;
let
  username = config.modules.other.system.username;
  cfg = config.modules.programs.firefox;
in {
  options.modules.programs.firefox = {
    enable = mkEnableOption "firefox";
    extensions = mkOption {
      description =
        "firefox extensions (format like https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265)";
      type = types.attrs;
      default = { };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.firefox = {
        enable = true;

        policies = {
          DisableTelemetry = true;
          DisableFirefoxStudies = true;
          EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
          };
          DisablePocket = true;
          DisableFirefoxAccounts = true;
          DisableAccounts = true;
          DisableFirefoxScreenshots = true;
          OverrideFirstRunPage = "";
          OverridePostUpdatePage = "";
          DontCheckDefaultBrowser = true;
          DisplayBookmarksToolbar =
            "never"; # alternatives: "always" or "newtab"
          DisplayMenuBar =
            "default-off"; # alternatives: "always", "never" or "default-on"
          SearchBar = "unified"; # alternative: "separate"
          FirefoxSuggest = {
            WebSuggestions = true;
            ImproveSuggest = true;
            Locked = true;
          };
          SearchSuggestEnabled = true;
          theme = {
            colors = {
              background-darker = "181825";
              background = "1e1e2e";
              foreground = "cdd6f4";
            };
          };

          OfferToSaveLogins = false;

          font = "Lexend";
          ExtensionSettings = lib.mkMerge [
            {
              "uBlock0@raymondhill.net" = {
                install_url =
                  "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
                installation_mode = "force_installed";
              };
            }
            cfg.extensions
          ];
        };
      };
    };
  };
}
