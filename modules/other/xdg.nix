{
    pkgs, config,
    ...
}: let
    username = config.modules.other.system.username;
    hmCfg = config.home-manager.users.${username};

    primary_browser = "schizofox.desktop";
    mail_client = "thunderbird.desktop";
    file_manager = "pcmanfm.desktop";
    media_player = "mpv.desktop";
    image_viewer = "imv.desktop";
    text_editor = "nvim.desktop";
in {

/*    environment.sessionVariables = {
        CARGO_HOME = "${hmCfg.xdg.dataHome}/cargo";
        GOPATH = "${hmCfg.xdg.dataHome}/go";
        GNUPGHOME = "${hmCfg.xdg.dataHome}/gnupg";
        GRADLE_USER_HOME = "${hmCfg.xdg.dataHome}/gradle";
        HISTFILE = "${hmCfg.xdg.stateHome}/bash/history";
        MYSQL_HISTFILE = "${hmCfg.xdg.stateHome}/mysql/history";
        NPM_CONFIG_USERCONFIG = "${hmCfg.xdg.configHome}/npm/npmrc";
        NUGET_PACKAGES = "${hmCfg.xdg.cacheHome}/NuGetPackages";
        JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${hmCfg.xdg.configHome}/java";
        PARALLEL_HOME = "${hmCfg.xdg.configHome}/parallel";
        PYTHONSTARTUP = "${hmCfg.xdg.configHome}/python/pythonrc";
        RUSTUP_HOME = "${hmCfg.xdg.dataHome}/rustup";
        WINEPREFIX = "${hmCfg.xdg.dataHome}/wine";
        XAUTHORITY = "\$XDG_RUNTIME_DIR/Xauthority";
    };
*/
    modules.programs.zsh.extraAliases = {
        gdb = "gdb -n -x ${hmCfg.xdg.configHome}/gdb/init";
        pidgin = "pidgin --config=${hmCfg.xdg.dataHome}/purple";
        svn = "svn --config-dir ${hmCfg.xdg.configHome}/subversion";
        wget = "wget --hsts-file=\"${hmCfg.xdg.dataHome}/wget-hsts\"";
    };
    xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
            xdg-desktop-portal-gtk
        ];
    };
      
    home-manager.users.${username} = {
        xdg.configFile."npm/npmrc".text = ''
            prefix=${hmCfg.xdg.dataHome}/npm
            cache=${hmCfg.xdg.cacheHome}/npm
            tmp=\$XDG_RUNTIME_DIR/npm
            init-module=${hmCfg.xdg.configHome}/npm/config/npm-init.js
        '';

        xdg.configFile."python/pythonrc".text = ''
            import os
            import atexit
            import readline

            history = os.path.join(os.environ['XDG_CACHE_HOME'], 'python_history')
            try:
                readline.read_history_file(history)
            except OSError:
                pass

            def write_history():
                try:
                    readline.write_history_file(history)
                except OSError:
                    pass

            atexit.register(write_history)
        '';
        xdg = {
            cacheHome = "${hmCfg.home.homeDirectory}/.cache";
            configHome = "${hmCfg.home.homeDirectory}/.config";
            dataHome = "${hmCfg.home.homeDirectory}/.local/share";
            stateHome = "${hmCfg.home.homeDirectory}/.local/state";
            mimeApps = {
                enable = true;
                defaultApplications = {
                    "text/html" = [ primary_browser ];
                    "x-scheme-handler/http" = [ primary_browser ];
                    "x-scheme-handler/https" = [ primary_browser ];
                    "x-scheme-handler/about" = [ primary_browser ];
                    "x-scheme-handler/unknown" = [ primary_browser ];
                    "x-scheme-handler/mailto" = [ mail_client ];
                    "message/rfc822" = [ mail_client ];
                    "x-scheme-handler/mid" = [ mail_client ];
                    "inode/directory" = [ file_manager ];
                    "x-scheme-handler/heroic" = [ "heroic.desktop" ];
                    "audio/mp3" = [ media_player ];
                    "audio/ogg" = [ media_player ];
                    "audio/mpeg" = [ media_player ];
                    "audio/aac" = [ media_player ];
                    "audio/opus" = [ media_player ];
                    "audio/wav" = [ media_player ];
                    "audio/webm" = [ media_player ];
                    "audio/3gpp" = [ media_player ];
                    "audio/3gpp2" = [ media_player ];
                    "video/mp4" = [ media_player ];
                    "video/x-msvideo" = [ media_player ];
                    "video/mpeg" = [ media_player ];
                    "video/ogg" = [ media_player ];
                    "video/mp2t" = [ media_player ];
                    "video/webm" = [ media_player ];
                    "video/3gpp" = [ media_player ];
                    "video/3gpp2" = [ media_player ];
                    "image/png" = [ image_viewer ];
                    "image/jpeg" = [ image_viewer ];
                    "image/gif" = [ image_viewer ];
                    "image/avif" = [ image_viewer ];
                    "image/bmp" = [ image_viewer ];
                    "image/vnd.microsoft.icon" = [ image_viewer ];
                    "image/svg+xml" = [ image_viewer ];
                    "image/tiff" = [ image_viewer ];
                    "image/webp" = [ image_viewer ];
                    "text/plain" = [ text_editor ];
                };
            };
        };
    };
}
