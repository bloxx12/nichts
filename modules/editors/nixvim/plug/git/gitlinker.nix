{
  programs.nixvim.plugins.gitlinker = {
    enable = true;
    callbacks = {
      "gihub.com" = "get_github_type_url";
    };
  };
}
