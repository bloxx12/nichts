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
  grub-theme = pkgs.stdenv.mkDerivation {
    pname = "catppuccin-grub";
    version = "0";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "grub";
      rev = "803c5df0e83aba61668777bb96d90ab8f6847106"; 
      sha256 = "sha256-/bSolCta8GCZ4lP0u5NVqYQ9Y3ZooYCNdTwORNvR7M0=";
    };
    installPhase = ''
      # runHook preInstall


      mkdir -p $out/

      cp -r $src/src/catppuccin-mocha-grub-theme/* $out/



      # runHook postInstall
    '';
  };
  catppuccin-sddm-corners-patched = pkgs.catppuccin-sddm-corners.overrideAttrs (prevAttrs: {
    postInstall = (prevAttrs.postInstall or "") + ''
      sed -i -E "s/passwordMaskDelay: [0-9]+/passwordMaskDelay: 0/" $out/share/sddm/themes/catppuccin-sddm-corners/components/PasswordPanel.qml
    '';
  });

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
  environment.systemPackages = [ catppuccin-sddm-corners-patched ];
  services.displayManager.sddm.theme = "catppuccin-sddm-corners";

  boot.loader.grub.theme = grub-theme;

}
