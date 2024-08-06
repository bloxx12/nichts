{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.system.programs.firefox;
  inherit (config.modules.other.system) username;

  inherit (lib) mkIf;
  inherit (builtins) listToAttrs;
in {
  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      imports = [inputs.schizofox.homeManagerModule];

      programs.schizofox = {
        enable = true;

        theme = {
          colors = {
            background-darker = "000000";
            background = "3a3432";
            foreground = "f7f7f7";
          };

          font = "Lexend";

          extraUserChrome = ''
            @namespace url("http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul"); /* set default namespace to XUL */

            /*
             * Hide tab bar, navigation bar and scrollbars
             * !important may be added to force override, but not necessary
             * #content is not necessary to hide scroll bars
             */

            #TabsToolbar {visibility: collapse;}
            /* #navigator-toolbox {visibility: collapse;} */
            browser {margin-right: -14px; margin-bottom: -14px;}
          '';
        };

        search = {
          defaultSearchEngine = "DuckDuckGo";
          removeEngines = ["Google" "Bing" "Amazon.com" "eBay" "Twitter" "Wikipedia"];
          addEngines = [
            {
              Name = "NixOS Packages";
              Description = "NixOS Unstable package search";
              Alias = "!np";
              Method = "GET";
              URLTemplate = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";
            }
            {
              Name = "NixOS Options";
              Description = "NixOS Unstable option search";
              Alias = "!no";
              Method = "GET";
              URLTemplate = "https://search.nixos.org/options?channel=unstable&query={searchTerms}";
            }
            {
              Name = "NixOS Wiki";
              Description = "NixOS Wiki search";
              Alias = "!nw";
              Method = "GET";
              URLTemplate = "https://nixos.wiki/index.php?search={searchTerms}";
            }
            {
              Name = "Home Manager Options";
              Description = "Home Manager option search";
              Alias = "!hm";
              Method = "GET";
              URLTemplate = "https://home-manager-options.extranix.com/?query={searchTerms}&release=master";
            }
            {
              Name = "Arch Wiki";
              Description = "Arch Wiki search";
              Alias = "!aw";
              Method = "GET";
              URLTemplate = "https://wiki.archlinux.org/index.php?search={searchTerms}";
            }
            {
              Name = "Gentoo Wiki";
              Description = "Gentoo Wiki search";
              Alias = "!gw";
              Method = "GET";
              URLTemplate = "https://wiki.gentoo.org/index.php?search={searchTerms}";
            }
            {
              Name = "Debian Wiki";
              Description = "Debian Wiki search";
              Alias = "!dw";
              Method = "GET";
              URLTemplate = "https://wiki.debian.org/FrontPage?action=fullsearch&value={searchTerms}";
            }
            {
              Name = "noogle";
              Descriptiom = "Noogle Search";
              Alias = "!ng";
              Method = "GET";
              URLTemplate = "https://noogle.dev/";
            }
          ];
        };
        extensions = {
          simplefox.enable = false;
          darkreader.enable = true;
          enableExtraExtensions = true;
          enableDefaultExtensions = true;
          extraExtensions = let
            extensions = [
              {
                id = "{c2c003ee-bd69-42a2-b0e9-6f34222cb046}";
                name = "auto-tab-discard";
              }
              {
                id = "{74145f27-f039-47ce-a470-a662b129930a}";
                name = "clearurls";
              }
              {
                id = "DontFuckWithPaste@raim.ist";
                name = "dont-fuck-with-paste";
              }
              {
                id = "{96ef5869-e3ba-4d21-b86e-21b163096400}";
                name = "font-fingerprint-defender";
              }
              {
                id = "uBlock0@raymondhill.net";
                name = "uBlock Origin";
              }
              {
                id = "{d7742d87-e61d-4b78-b8a1-b469842139fa}";
                name = "vimium-ff";
              }
              {
                id = "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}";
                name = "refined-github-";
              }
              {
                id = "sponsorBlocker@ajay.app";
                name = "sponsorblock";
              }
              {
                id = "treestyletab@piro.sakura.ne.jp";
                name = "Tree Style Tab";
              }
            ];

            # shamelessly stolen from raf, thanks.
            mappedExtensions =
              map (extension: {
                name = extension.id;
                value = {
                  install_url = "https://addons.mozilla.org/firefox/downloads/latest/${extension.name}/latest.xpi";
                };
              })
              extensions;
          in
            listToAttrs mappedExtensions;
        };

        security = {
          sanitizeOnShutdown = false;
          sandbox = true;
          noSessionRestore = false;
          userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:106.0) Gecko/20100101 Firefox/106.0";
        };

        misc = {
          drm.enable = true;
          contextMenu.enable = true;
        };

        # taken from diniamo
        settings = {
          "gfx.webrender.all" = true;
          "media.ffmpeg.vaapi.enabled" = true;
          "media.rdd-ffmpeg.enabled" = true;
          "media.av1.enabled" = true;
          "gfx.x11-egl.force-enabled" = true;
          "widget.dmabuf.force-enabled" = true;

          "browser.ctrlTab.sortByRecentlyUsed" = true;
          # This makes websites prefer a dark theme (in theory)
          "layout.css.prefers-color-scheme.content-override" = 0;
          "widget.use-xdg-desktop-portal.file-picker" = 1;
          # Leaving this on breaks a lot
          # "privacy.resistFingerprinting" = false;
          "permissions.fullscreen.allowed" = true;
          "dom.webnotifications.enabled" = true;
        };
      };
    };
  };
}
