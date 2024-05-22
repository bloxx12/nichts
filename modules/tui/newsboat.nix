{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.programs.newsboat;
  username = config.modules.other.system.username;
in {
  options.modules.programs.newsboat.enable = mkEnableOption "newsboat";

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.newsboat = {
        enable = true;
        autoReload = true;
        extraConfig = ''
          download-full-page yes
          download-retries 3
          error-log /dev/null
          cookie-cache ~/.cache/newsboat/cookies.txt
          bind-key j down
          bind-key k up
          bind-key G end
          bind-key g home
          bind-key d pagedown
          bind-key u pageup
          bind-key a toggle-article-read
          macro x set browser "setsid -f mpv --really-quiet --no-terminal" ; open-in-browser ; set browser librewolf

          color listnormal         color15 default
          color listnormal_unread  color2  default
          color listfocus_unread   color2  color0
          color listfocus          default color0
          color background         default default
          color article            default default
          color end-of-text-marker color8  default
          color info               color4  color8
          color hint-separator     default color8
          color hint-description   default color8
          color title              color14 color8

          highlight article "^(Feed|Title|Author|Link|Date): .+" color4 default bold
          highlight article "^(Feed|Title|Author|Link|Date):" color14 default bold
          highlight article "\\((link|image|video)\\)" color8 default
          highlight article "https?://[^ ]+" color4 default
          highlight article "\[[0-9]+\]" color6 default bold
          user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36"
        '';
        urls = [
          {
            title = "NixOS Weekly";
            url = "https://weekly.nixos.org/feeds/all.rss.xml";
          }
          {
            title = "Veronica Explains";
            url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCMiyV_Ib77XLpzHPQH_q0qQ";
          }
          {
            title = "Mental Outlaw";
            url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC7YOGHUfC1Tb6E4pudI9STA";
          }
          {
            title = "Hacker News";
            url = "https://hnrss.org/newest";
          }
          {
            title = "Phoronix";
            url = "https://www.phoronix.com/rss.php";
          }
          {
            title = "LWN";
            url = "https://lwn.net/headlines/rss";
          }
          {
            title = "Hyprland Commit Feed";
            url = "https://github.com/hyprwm/Hyprland/commits/main.atom";
          }
        ];
      };
    };
  };
}
