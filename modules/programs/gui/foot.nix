{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.system.programs.terminals.foot;
  colours  = config.modules.style.colorScheme.colors;

  inherit (lib) mkIf;
  foot-config = pkgs.writeText "foot.ini" (lib.generators.toINI {} {
    main = {
      term = "foot";
      app-id = "foot";
      title = "foot";
      locked-title = "no";

      font = "Iosevka Nerd Font:size=16";
      font-bold = "Iosevka Nerd Font:size=16";

      line-height = 20;
      letter-spacing = 0;

      horizontal-letter-offset = 0;
      vertical-letter-offset = 0;
      box-drawings-uses-font-glyphs = "no";
      dpi-aware = "no";

      bold-text-in-bright = "no";
      word-delimiters = ",│`|:\"'()[]{}<>";
      selection-target = "primary";

      initial-window-size-chars = "104x36";
      initial-window-mode = "windowed";
      pad = "8x8 center";
      resize-delay-ms = 100;
    };

    desktop-notifications.command = "${pkgs.libnotify}/bin/notify-send -a \${app-id} -i \${app-id} \${title} \${body}";

    bell = {
      urgent = "yes";
      notify = "yes";
      command = "${pkgs.libnotify}/bin/notify-send bell";
      command-focused = "no";
    };

    scrollback = {
      lines = 10000;
      multiplier = 10.0;
      indicator-position = "relative";
      indicator-format = "line";
    };

    url = {
      launch = "${pkgs.xdg-utils}/bin/xdg-open \${url}";
      label-letters = "sadfjklewcmpgh";
      osc8-underline = "always";
      protocols = "http, https, ftp, ftps, file, gemini, gopher, irc, ircs";
      uri-characters = ''
        abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.,~:;/?#@!$&%*+="'()[]'';
    };

    tweak = {
      font-monospace-warn = "no";
      sixel = "yes";
    };
    cursor = {
      style = "beam";
      blink = "no";
    };

    mouse = {
      hide-when-typing = "yes"; # not really needed since we already enable this in Hyprland.
      alternate-scroll-mode = "yes";
    };
    csd.preferred = "server";
    key-bindings = {
      scrollback-up-half-page = "Control+k";
      scrollback-up-page = "Control+Shift+k";
      scrollback-down-half-page = "Control+j";
      scrollback-down-page = "Control+Shift+j";
    };
    mouse-bindings = {
      selection-override-modifiers = "Shift";
      primary-paste = "BTN_MIDDLE";
      select-begin = "BTN_LEFT";
      select-begin-block = "Control+BTN_LEFT";
      select-extend = "BTN_RIGHT";
      select-extend-character-wise = "Control+BTN_RIGHT";
      select-word = "BTN_LEFT-2";
      select-word-whitespace = "Control+BTN_LEFT-2";
    };
    colors = with colours; {
      background = base00; # base color
      foreground = base05; # text color

      regular0 = base03; # black
      regular1 = base08; # red
      regular2 = base0B; # green
      regular3 = base0A; # yellow
      regular4 = base0D; # blue
      regular5 = base0F; #magenta
      regular6 = base0C; #cyan
      regular7 = base06; #white

      bright0 = base04; # Surface 2
      bright1 = base08; # red
      bright2 = base0B; # green
      bright3 = base0A; # yellow
      bright4 = base0D; # blue
      bright5 = base0F; # pink
      bright6 = base0C; # teal
      bright7 = base07; # Subtext 0

      alpha = 1.0;
    };
  });
  foot-wrapped = pkgs.symlinkJoin {
    name = "foot-wrapped";
    paths = [pkgs.foot];
    buildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/foot --add-flags "--config=${foot-config}"
    '';
  };
in {
  config = mkIf cfg.enable {
    environment.systemPackages = [foot-wrapped];
  };
}
