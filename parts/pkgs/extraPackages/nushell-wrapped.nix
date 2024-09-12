{
  inputs,
  lib,
  pkgs,
  ...
}: let

  nushell-wrapped = inputs.wrapper-manager.lib.build {
    inherit pkgs;
    modules = [
      {
        wrappers.nushell-wrapped = {
          basePackage = pkgs.nushell;
          pathAdd = with pkgs; [
            # better cd
            zoxide
            #better ls
            eza

            # better grep
            ripgrep

            # better dig
            dogdns

            # simply the best fetch tool out there
            microfetch

            fzf

iputils
            gnumake
            gping
            asciinema
            inetutils
            scc
            onefetch
            wget
            cpufetch
            yt-dlp
            tealdeer
            glow
            hyperfine
            imagemagick
            ffmpeg-full
            catimg
            nmap
            wget
            fd
            jq
            rsync
            figlet
            unzip
            zip
          ];
        };
      }
    ];
  };
in
  nushell-wrapped
