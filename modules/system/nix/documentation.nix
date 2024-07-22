{
  # faster rebuilding
  documentation = {
    # whether to enable the `doc` output of packages
    # generally in ${pkg}/share/ as plaintext or html
    #  # can shave off a few megabytes
    #  doc.enable = false;
    #
    #  # whether to install the `info` command and the `info`
    #  # output of packages
    #  info.enable = false;
    #
    #  man = {
    #    # Whether to install manual pages
    #    # this means packages that provide a `man` output will have said output
    #    # included in the final closure
    #    enable = true;
    #
    #    # Whether to generate the manual page index caches
    #    # if true, it becomes possible to search for a page or keyword
    #    # using utilities like apropos(1) and the -k option of man(1).
    #    generateCaches = true;
    #
    #    # Whether to enable mandoc as the default man page viewer.
    #    mandoc.enable = false; # my default manpage viewer is Neovim, so this isn't necessary
    #  };
  };
}
