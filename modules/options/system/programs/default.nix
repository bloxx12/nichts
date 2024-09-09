{lib, ...}: let
  inherit (lib) mkEnableOption mkOption types;
in {
  options.modules.system.programs = {
    editors = {
      emacs.enable = mkEnableOption "Emacs operatig system";
      neovim.enable = mkEnableOption "Neovim text editor";
      helix.enable = mkEnableOption "Helix text editor";
      kakoune.enable = mkEnableOption "Kakoune text editor";
    };

    discord.enable = mkEnableOption "Discord messenger";
    spotify.enable = mkEnableOption "Spotify music client";
    zathura.enable = mkEnableOption "Zathura pdf viewer";
    nextcloud.enable = mkEnableOption "Nextcloud sync client";
    firefox.enable = mkEnableOption "Firefox web browser";
    zellij.enable = mkEnableOption "Zellij terminal multiplexer";
    steam.enable = mkEnableOption "Steam games platform";

    eza.enable = mkEnableOption "eza";
    oh-my-posh.enable = mkEnableOption "oh-my-posh";
    nushell.enable = mkEnableOption "nushell";
    terminals = {
      foot.enable = mkEnableOption "Foot terminal emulator";
      kitty.enable = mkEnableOption "Kitty terminal emulator";
    };

    git = {
      signingKey = mkOption {
        type = types.str;
        default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILPiRe9OH/VtWFWyy5QbAVcN7CLxr4zUtRCwmxD6aeN6";
        description = "The default gpg key used for signing commits";
      };
    };
    default = {
      terminal = mkOption {
        type = types.enum ["foot" "kitty"];
        default = "foot";
      };
      fileManager = mkOption {
        type = types.enum ["thunar" "dolphin" "nemo"];
        default = "thunar";
      };
      browser = mkOption {
        type = types.enum ["firefox" "librewolf" "chromium"];
        default = "firefox";
      };
      editor = mkOption {
        type = types.enum ["neovim" "helix" "emacs"];
        default = "emacs";
      };
      launcher = mkOption {
        type = types.enum ["anyrun" "rofi" "wofi"];
        default = "anyrun";
      };
    };
  };
}
