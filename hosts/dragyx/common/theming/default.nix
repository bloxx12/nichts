{ config, pkgs, ... }: 

# TODO: Make this more generic / reusable
let 
  username = config.modules.other.system.username;
  gitPath = config.modules.other.system.gitPath;

  variant = "frappe";


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
  # catppuccin-sddm-corners-patched = pkgs.catppuccin-sddm-corners.overrideAttrs (prevAttrs: {

  #   postInstall = (prevAttrs.postInstall or "") + ''
  #     sed -i -E "s/passwordMaskDelay: [0-9]+/passwordMaskDelay: 0/" $out/share/sddm/themes/catppuccin-sddm-corners/components/PasswordPanel.qml
  #   '';
  # });
  catppuccin-sddm = pkgs.stdenv.mkDerivation rec {
    pname="catppuccin-sddm";
    version="1.0.0";
    dontBuild = true;
    src =  pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "sddm";
      rev = "v${version}"; 
      sha256 = "sha256-SdpkuonPLgCgajW99AzJaR8uvdCPi4MdIxS5eB+Q9WQ=";
    };
    # nativeBuildInputs = with pkgs; [ qt6.qtsvg qt6.qtdeclarative ];
    installPhase = ''
      runHook preInstall
      theme_dir="$out/share/sddm/themes/";
      mkdir -p $theme_dir

      for variant in "latte" "frappe" "macchiato" "mocha"; do
        this_theme="$theme_dir/catppuccin-$variant"
        mkdir "$this_theme"
        cp -r $src/src/* $this_theme
        # replace the theme name in the metadata file
        sed -i -e "s/%%THEME%%/$variant/g" "$this_theme/metadata.desktop"

        
        # handle items that are different per theme
        cp "$src/pertheme/$variant.png" "$this_theme/preview.png"
        cp "$src/pertheme/$variant.conf" "$this_theme/theme.conf"
      done

      runHook postInstall
    '';


  };
  catppuccin-wallpapers = pkgs.stdenv.mkDerivation {
    pname="catppuccin-wallpapers";
    version = "0";
    src = pkgs.fetchFromGitHub {
      owner = "zhichaoh";
      repo = "catppuccin-wallpapers";
      rev = "1023077979591cdeca76aae94e0359da1707a60e"; 
      sha256 = "sha256-h+cFlTXvUVJPRMpk32jYVDDhHu1daWSezFcvhJqDpmU=";
    };
    installPhase = ''
      mkdir -p $out/
      cp -r $src/* $out/
    '';
  };

  catppuccin = (pkgs.catppuccin.override {
    inherit variant;
  });
  catppuccin-waybar = pkgs.stdenv.mkDerivation rec {
    name = "catppuccin-waybar";
    version = "1.1";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "waybar";
      rev = "v${version}";
      hash = "sha256-9lY+v1CTbpw2lREG/h65mLLw5KuT8OJdEPOb+NNC6Fo=";
    };
    installPhase = ''
      runHook preInstall
      mkdir -p $out
      cp $src/themes/* $out/

      runHook postInstall
    '';

    };

in
{
  home-manager.users.${username} = {
    xdg.configFile."rofi".source = "${catpuccin-rofi}/.config";
    xdg.dataFile."rofi/themes".source = "${catpuccin-rofi}/share";

    programs.waybar.style = ./waybar-style.css;
    # add catppuccin theme to waybar
    xdg.configFile."waybar/catppuccin.css".source = "${catppuccin-waybar}/${variant}.css";

    wayland.windowManager.hyprland.settings.exec-once = [
      "hyprshade auto"
      "dunst"
      "hyprpaper"
    ];

    xdg.configFile."hypr/hyprpaper.conf" = { #TODO: generic path
      text = ''
        preload = ${catppuccin-wallpapers}/landscapes/Rainnight.jpg
        wallpaper = ,${catppuccin-wallpapers}/landscapes/Rainnight.jpg
      '';
    };
  };
  environment.systemPackages = with pkgs; [ 
    # catppuccin-sddm-corners-patched 
    catppuccin
    catppuccin-sddm

    # deps of catppuccin-sddm-corners-patched
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtsvg
    libsForQt5.qt5.qtquickcontrols
    qt6.qtsvg qt6.qtdeclarative
    qt6.qtwayland
  ];
  services.displayManager.sddm = {
    theme = "catppuccin-${variant}";
    package = pkgs.kdePackages.sddm; # NEEDED for the catppuccin theme
  };

  boot.loader.grub.theme = grub-theme;

}
