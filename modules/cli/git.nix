{
    config,
    lib,
    pkgs,
    ...
}: with lib; let
    cfg = config.myOptions.programs.git;
    username = config.myOptions.other.system.username;
in {
    options.myOptions.programs.git = {
        enable = mkEnableOption "git";
        userName = mkOption {
            type = types.str;
            description = "git username";
        };
        userEmail = mkOption {
            type = types.str;
            description = "git email";
        };
#        signingKey = mkOption {
 #           type = types.str;
  #          description = "git commit signing key";
   #     };
        editor = mkOption {
            type = types.str;
            default = "$EDITOR";
            description = "commit message editor";
        };
        defaultBranch = mkOption {
            type = types.str;
            default = "master";
            description = "default git branch";
        };
	pullRebase = mkOption {
	    type = types.bool;
	    default = false;
	    description = "git config pull.rebase {pullRebase}";
	};
    };

    config = mkIf cfg.enable {
        home-manager.users.${username} = {
            programs.git = {
                inherit (cfg) enable userName userEmail;
                extraConfig = {
                    core = {
                        editor = cfg.editor;
                        pager = "${pkgs.delta}/bin/delta";
                    };
                    init.defaultBranch = cfg.defaultBranch;
                    push.autoSetupRemote = true;
                    commit = {
                        verbose = true;
                        # gpgsign = true;
                    };
                    # gpg.format = "ssh";
#                    user.signingkey = "key::${cfg.signingKey}";
                    merge.conflictstyle = "zdiff3";
                    interactive.diffFilter = "${pkgs.delta}/bin/delta --color-only";
                    diff.algorithm = "histogram";
                    transfer.fsckobjects = true;
                    fetch.fsckobjects = true;
                    receive.fsckobjects = true;
		    pull.rebase = cfg.pullRebase;
                };
            };
        };
    };
}
