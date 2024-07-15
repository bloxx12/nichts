{pkgs, ...}: {
  documentation = {
    enable = true;
    dev.enable = true;
    doc.enable = false;
    info.enable = false;
    man = {
      enable = true;
      generateCaches = false;
      man-db.enable = false;
      mandoc.enable = true;
    };
    nixos = {
      includeAllModules = false;
    };
  };

  environment.systemPackages = with pkgs; [
    man-pages
    man-pages-posix
  ];
}
