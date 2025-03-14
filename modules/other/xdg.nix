{
  config,
  pkgs,
  ...
}: let
  inherit (config.meta.mainUser) username;

  primary_browser = "Librewolf.desktop";
  mail_client = "thunderbird.desktop";
  file_manager = "nautilus.desktop";
  media_player = "mpv.desktop";
  image_viewer = "imv.desktop";
  text_editor = "helix.desktop";
  terminal = "foot.desktop";
  pdf_viewer = "sioyek.desktop";
in {
  environment = {
    systemPackages = [pkgs.xdg-utils];
    sessionVariables = {
      TERMINAL = "${terminal}";
      XDG_CACHE_HOME = "/home/${username}/.config";
    };
  };

  xdg.mime = {
    defaultApplications = {
      "text/html" = [primary_browser];
      "x-scheme-handler/http" = [primary_browser];
      "x-scheme-handler/https" = [primary_browser];
      "x-scheme-handler/about" = [primary_browser];
      "x-scheme-handler/unknown" = [primary_browser];
      "x-scheme-handler/mailto" = [mail_client];
      "message/rfc822" = [mail_client];
      "x-scheme-handler/mid" = [mail_client];
      "inode/directory" = [file_manager];
      "audio/mp3" = [media_player];
      "audio/ogg" = [media_player];
      "audio/mpeg" = [media_player];
      "audio/aac" = [media_player];
      "audio/opus" = [media_player];
      "audio/wav" = [media_player];
      "audio/webm" = [media_player];
      "audio/3gpp" = [media_player];
      "audio/3gpp2" = [media_player];
      "video/mp4" = [media_player];
      "video/x-msvideo" = [media_player];
      "video/mpeg" = [media_player];
      "video/ogg" = [media_player];
      "video/mp2t" = [media_player];
      "video/webm" = [media_player];
      "video/3gpp" = [media_player];
      "video/3gpp2" = [media_player];
      "image/png" = [image_viewer];
      "image/jpeg" = [image_viewer];
      "image/gif" = [image_viewer];
      "image/avif" = [image_viewer];
      "image/bmp" = [image_viewer];
      "image/vnd.microsoft.icon" = [image_viewer];
      "image/svg+xml" = [image_viewer];
      "image/tiff" = [image_viewer];
      "image/webp" = [image_viewer];
      "text/plain" = [text_editor];
      "application/pdf" = [pdf_viewer];
    };
  };
}
