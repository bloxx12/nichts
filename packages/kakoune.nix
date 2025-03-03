{
  fetchFromGitHub,
  makeWrapper,
  stdenv,
  symlinkJoin,
  kakounePlugins,
  ...
}: let
  custom-kakoune = stdenv.mkDerivation {
    name = "custom-kakoune";
    src = fetchFromGitHub {
      owner = "mawww";
      repo = "kakoune";
      rev = "be82047dbf5f74f123e925b96e0e13962a4e0c09";
      hash = "sha256-akSmIe0SUe9re8a90ssrykowCzThZnzqVow9erT+0U4=";
    };

    makeFlags = ["debug=no" "PREFIX=${placeholder "out"}"];

    enableParallellBuilding = true;

    doInstallCheck = false;
    installCheckPhase = ''
      $out/bin/kak -ui json -e "kill 0"
    '';
    postInstall = ''
      cd "$out/share/kak"
      autoload_target=$(readlink autoload)
      rm autoload
      mkdir autoload
      ln -s --relative "$autoload_target" autoload
    '';
  };
  plugins = builtins.attrValues {
    inherit (kakounePlugins) fzf-kak kakoune-catppuccin;
  };

  kakoune-wrapped = symlinkJoin {
    name = "kakoune-wrapped";
    nativeBuildInputs = [makeWrapper];
    paths = [custom-kakoune] ++ plugins;

    postBuild = ''
      # create a directory for bins that kakoune needs
      # access to, without polluting the users path by adding
      # that binary nested with this symlinkJoin.
      mkdir -p $out/share/kak/bin

      # location of kak binary is used to find ../share/kak/autoload,
      # unless explicitly overriden with KAKOUNE_RUNTIME
      rm "$out/bin/kak"
      makeWrapper "${custom-kakoune}/bin/kak" "$out/bin/kak" \
        --set KAKOUNE_RUNTIME "$out/share/kak" \
        --suffix PATH : "$out/share/kak/bin"

      # currently kakoune ignores doc files if they are symlinks, so workaround by
      # copying doc files over, so they become regular files...
      mkdir "$out/DELETE_ME"
      mv "$out/share/kak/doc" "$out/DELETE_ME"
      cp -r --dereference "$out/DELETE_ME/doc" "$out/share/kak"
      rm -Rf "$out/DELETE_ME"
    '';
  };
in
  kakoune-wrapped
