{ config, pkgs, ... }: 

# TODO: Make this more generic / reusable
let 
  username = config.modules.other.system.username;
  gitPath = config.modules.other.system.gitPath;


  catpuccin-rofi = pkgs.stdenv.mkDerivation {
    pname = "catppuccin-rofi";
    version = "0";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "rofi";
      rev = "5350da41a11814f950c3354f090b90d4674a95ce"; 
      sha256 = "sha256-DNorfyl3C4RBclF2KDgwvQQwixpTwSRu7fIvihPN8JY=";
    };
    installPhase = ''
      mkdir -p $out/share/
      mkdir -p $out/.config/

      cp -r $src/basic/.config/rofi/* $out/.config/
      cp -r $src/basic/.local/share/rofi/themes/* $out/share/
    '';
  };
in
{
  home-manager.users.${username} = {
    xdg.configFile."rofi".source = "${catpuccin-rofi}/.config";
    xdg.dataFile."rofi/themes".source = "${catpuccin-rofi}/share";

    programs.waybar.style = ./waybar-style.css;

    wayland.windowManager.hyprland.settings.exec-once = [
      "hyprshade auto"
      "dunst"
      "hyprpaper"
    ];

    xdg.configFile."hypr/hyprpaper.conf" = { #TODO: generic path
      text = ''
        preload = ${gitPath}/hosts/dragyx/common/theming/wallpaper/default.jpg
        wallpaper = ,${gitPath}/hosts/dragyx/common/theming/wallpaper/default.jpg
      '';
    };
  };

}
