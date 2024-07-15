{
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.modules.programs.schizofox;
  inherit (config.modules.other.system) username;

  inherit (lib) mkEnableOption mkIf;
in {
  options.modules.programs.schizofox = {enable = mkEnableOption "schizofox";};

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      imports = [inputs.schizofox.homeManagerModule];

      programs.schizofox = {
        enable = true;
        theme = {
          #  colors = {
          #    background-darker = "181825";
          #    background = "1e1e2e";
          #    foreground = "cdd6f4";
          #  };
          colors = {
            background-darker = "1d2021";
            background = "282828";
            foreground = "ebdbb2";
          };

          font = "Lexend";
          extraUserChrome = ''
            body {
                color: red !important;
            }
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
          simplefox.enable = true;
          darkreader.enable = true;
          extraExtensions = let
            mkUrl = name: "https://addons.mozilla.org/firefox/downloads/latest/${name}/latest.xpi";
            extensions = [
              {
                id = "1018e4d6-728f-4b20-ad56-37578a4de76";
                name = "flagfox";
              }
              {
                id = "{c2c003ee-bd69-42a2-b0e9-6f34222cb046}";
                name = "auto-tab-discard";
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
                id = "uBlock0@raymondhill.net";
                name = "UBlock Origin";
              }
            ];
            extraExtensions = builtins.foldl' (acc: ext: acc // {ext.id = {install_url = mkUrl ext.name;};}) {} extensions;
          in
            extraExtensions;
        };
        security = {
          sanitizeOnShutdown = false;
          sandbox = true;
          userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:106.0) Gecko/20100101 Firefox/106.0";
        };

        misc = {
          drm.enable = true;
          disableWebgl = true;
        };
      };
    };
  };
}
