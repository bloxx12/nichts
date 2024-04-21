{ inputs, outputs, lib, pkgs, pkg-config, ... }: 

let 
newer_xwayland = self: super: {
  xwayland = super.xwayland.overrideAttrs (prev: {
    version = "23.2.6-HEAD";
    src = pkgs.fetchFromGitLab {
      domain = "gitlab.freedesktop.org";
      owner = "xorg";
      repo = "xserver";
      rev = "43f47e8e6597f06cf2082514c10a71965fa6d3c8";
      sha256 = "93DzgA8nXVodDvllCOIuTtOYWpUdXwzPIGpi2SUSNqo=";

    };
    mesonFlags = [
        # (lib.mesonBool "xwayland_eglstream" true)
        (lib.mesonBool "xcsecurity" true)
        # (lib.mesonOption "default_font_path" defaultFontPath)
        # (lib.mesonOption "xkb_bin_dir" "${xkbcomp}/bin")
        # (lib.mesonOption "xkb_dir" "${xkeyboard_config}/etc/X11/xkb")
        # (lib.mesonOption "xkb_output_dir" "${placeholder "out"}/share/X11/xkb/compiled")
        # (lib.mesonBool "libunwind" withLibunwind)
      ];
  }); 
};

newer_xorgproto = self: super: {
    xorg.xorgproto = super.xorg.xorgproto.overrideAttrs (prev: {
        pname = "xorgproto";
    version = "2023.2";
    builder = ./builder.sh;
    src = pkgs.fetchurl {
      url = "mirror://xorg/individual/proto/xorgproto-2023.2.tar.xz";
      sha256 = "0b4c27aq25w1fccks49p020avf9jzh75kaq5qwnww51bp1yvq7xn";
    };
    hardeningDisable = [ "bindnow" "relro" ];
    strictDeps = true;
    nativeBuildInputs = [ pkg-config pkgs.python3 ];
    buildInputs = [ pkgs.libXt ];
    # passthru.tests.pkg-config = testers.testMetaPkgConfig finalAttrs.finalPackage;
    meta = {
      pkgConfigModules = [ "applewmproto" "bigreqsproto" "compositeproto" "damageproto" "dmxproto" "dpmsproto" "dri2proto" "dri3proto" "evieproto" "fixesproto" "fontcacheproto" "fontsproto" "glproto" "inputproto" "kbproto" "lg3dproto" "presentproto" "printproto" "randrproto" "recordproto" "renderproto" "resourceproto" "scrnsaverproto" "trapproto" "videoproto" "windowswmproto" "xcalibrateproto" "xcmiscproto" "xextproto" "xf86bigfontproto" "xf86dgaproto" "xf86driproto" "xf86miscproto" "xf86rushproto" "xf86vidmodeproto" "xineramaproto" "xproto" "xproxymngproto" "xwaylandproto" ];
      platforms = lib.platforms.unix;
    };
    });
};
in
{
  nixpkgs.overlays = [
    newer_xwayland
    newer_xorgproto
  ];
}
