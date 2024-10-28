{
  config,
  lib,
  pkgs,
  buildGoModule,
  ...
}:
with lib; let
  cfg = config.modules.programs.kakoune;
  username = config.modules.other.system.username;
  kakship = pkgs.rustPlatform.buildRustPackage rec {
    pname = "kakship";
    version = "0.2.8";
    src = pkgs.fetchFromGitHub {
      owner = "mesabloo";
      repo = "kakship";
      rev = "937d904a893daf59f70dc955e60209cd8866a7c3";
      sha256 = "1pk0v0b31bppjzl08qgrjld40pc7rqc257zzgdl4r8zaamqsmkz9";
    };
    cargoLock = {
      lockFile = "${src}/Cargo.lock";
      outputHashes = {
        "kak-0.1.2" = "sha256-RhtHQkC9yCSJtr/kbC5c9MavbL79acrsiEGXyoAST8U=";
        "yew-ansi-0.1.0" = "sha256-dSaEzqiOon+OqCZKQudzLRNP+Iv97kC+XZcTElKNrzs=";
      };
    };

    # patchPhase = ''
    #   substituteInPlace src/main.rs \
    #     --replace '"starship"' "\"${pkgs.starship}/bin/starship\""
    # '';

    postInstall = ''
      # Copy rc files to /share/kak/autoload
      mkdir -p $out/share/kak/autoload/plugins/${pname}
      cp $src/rc/*.kak $out/share/kak/autoload/plugins/${pname}
    '';
  };
  kak-rainbow = pkgs.kakouneUtils.buildKakounePluginFrom2Nix rec {
    pname = "kak-rainbow";
    version = "1.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "Bodhizafa";
      repo = "kak-rainbow";
      rev = "9c3d0aa62514134ee5cb86e80855d9712c4e8c4b";
      sha256 = "sha256-ryYq4A89wVUsxgvt4YqBPXsTFMDrMJM6BDBEHrWHD1c=";
    };

    postInstall = ''
      mkdir -p $out/lib
      mv $out/share/kak/autoload/plugins/${pname}/rainbow.kak $out/lib
      cat >$out/share/kak/autoload/plugins/${pname}/rainbow.kak <<EOF
        provide-module rainbow %{
          source $out/lib/rainbow.kak
        }
      EOF
    '';
  };
  kks = pkgs.buildGoModule rec {
    pname = "kks";
    version = "8113ea3";

    src = pkgs.fetchFromGitHub {
      owner = "kkga";
      repo = pname;
      rev = "8113ea3bd718dec88b812faa1a41bacba0110fd7";
      sha256 = "sha256-/0ocgWArELGQkOZqbYRljPnzM/zQ9HCZq7gqhMD0Mq4=";
    };

    vendorHash = "sha256-E4D9FGTpS9NkZy6tmnuI/F4dnO9bv8MVaRstxVPvEfo=";
    doCheck = false;

    meta = with lib; {
      description = "Handy Kakoune companion.";
      homepage = "https://github.com/kkga/kks";
      license = licenses.unfree;
      maintainers = with maintainers; [kalbasit];
    };
  };
  kak-alacritty = pkgs.kakouneUtils.buildKakounePluginFrom2Nix rec {
    pname = "alacritty.kak";
    version = "10025b8";
    src = pkgs.fetchFromGitHub {
      owner = "Lokasku";
      repo = pname;
      rev = "66b0d2e2451c01719262effd008c40614427bb35";
      sha256 = "sha256-Ibjs6dCU8/XEjUoWNB5a8R4QW7z8w6cFBSxd7UvZrxE=";
    };
  };
  kakoune-snow = pkgs.kakouneUtils.buildKakounePluginFrom2Nix rec {
    pname = "kakoune-snow";
    version = "35f8187";
    src = pkgs.fetchFromGitHub {
      owner = "caksoylar";
      repo = pname;
      rev = "35f81876bcaea061982396f8071b89528940ae61";
      sha256 = "";
    };
  };
  # with lib;
in {
  options.modules.programs.kakoune.enable = mkEnableOption "kakoune";
  config = mkIf cfg.enable {
    home-manager.users.${username} = {programs.kakoune.enable = true;};
    environment.systemPackages = with pkgs; [
      rust-analyzer
      rustfmt # Rust    LSP

      kakship
      kks
    ];
    programs.kakoune = {
      plugins = with pkgs.kakounePlugins; [
        kakoune-lsp
        fzf-kak
        kak-rainbow
        kak-alacritty
      ];
      config = {
        numberLines = {
          enable = true;
          # separator = "|";
        };
        scrollOff = {
          columns = 15;
          lines = 15;
        };
      };
      extraConfig = builtins.readFile ./kakrc;
    };

    xdg.configFile."kak/starship.toml".source = ./starship.toml;
    xdg.configFile."kak-lsp/kak-lsp.toml".source = ./kak-lsp.toml;
  };
}
