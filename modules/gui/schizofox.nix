{
    config,
    inputs,
    lib,
    ...
}: with lib; let
    cfg = config.myOptions.programs.schizofox;
    username = config.myOptions.other.system.username;
in {
    options.myOptions.programs.schizofox = {
        enable = mkEnableOption "schizofox";
    };

    config = mkIf cfg.enable {
        home-manager.users.${username} = {
            imports = [ inputs.schizofox.homeManagerModule ];
            programs.schizofox = {
                enable = true;

                theme = {
                  colors = {
                    background-darker = "181825";
                    background = "1e1e2e";
                    foreground = "cdd6f4";
                  };

                  font = "Lexend";

                  extraUserChrome = ''
                    body {
                      color: red !important;
                    }
                  '';
                };

                search = {
                  defaultSearchEngine = "Brave";
                  removeEngines = ["Google" "Bing" "Amazon.com" "eBay" "Twitter" "Wikipedia"];
                  searxUrl = "https://searx.be";
                  searxQuery = "https://searx.be/search?q={searchTerms}&categories=general";
                  addEngines = [
                    {
                      Name = "NixOS Packages";
                      Description = "NixOS Unstable package serach";
                      Alias = "!np";
                      Method = "GET";
                      URLTemplate = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";
                    }
                    {
                      Name = "Home Manager Options";
                      Description = "Home Manager option search";
                      Alias = "!hm";
                      Method = "GET";
                      URLTemplate = "https://mipmip.github.io/home-manager-option-search?query={searchTerms}";
                    }

                  ];
                };

                security = {
                  sanitizeOnShutdown = false;
                  sandbox = true;
                  userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:106.0) Gecko/20100101 Firefox/106.0";
                };

                misc = {
                  drmFix = true;
                  disableWebgl = false;
                };

                extensions = {
                  simplefox.enable = true;
                  darkreader.enable = true;

                  extraExtensions = {
                    "webextension@metamask.io".install_url = "https://addons.mozilla.org/firefox/downloads/latest/ether-metamask/latest.xpi";
                  };
                };

                bookmarks = [
                  {
                    Title = "Example";
                    URL = "https://example.com";
                    Favicon = "https://example.com/favicon.ico";
                    Placement = "toolbar";
                    Folder = "FolderName";
                  }
                ];
            };
        };
    };
}
