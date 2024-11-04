{
  config,
  lib,
  ...
}: let
  inherit (config.modules.system.hardware) monitors;
  inherit (lib) imap0 flatten optionalString;
  inherit (builtins) map genList attrNames toString;
in {
  programs.hyprland.settings = {
    # INFO: This is a custom function to map all of my monitors to workspaces.
    # Since I use split-monitor-workspaces, I map 10 workspaces to each monitor
    # and set the first one to be the default one.
    # To be able to use this for a varying amount of monitors we do some nasty trickery.
    # This was inspired by jacekpoz, whose configuration is linked in this project's README.md.
    workspace =
      # We're creating several lists of workspace assignments, one for each monitor,
      # and have to merge them into one big list.
      (flatten
        # We then use imap0 insted of map because imap0 starts indexing at zero as oppsed to one with map.
        (imap0 (monitorIndex: monitorName: (
            map (
              i: let
                # we define our own modulo operation for this,
                # since only the first workspace on each monitor is the default workspace.
                mod = a: b: a - (b * (a / b));
                workspace = toString i;
                isDefault = (mod i 10) == 1; # 11, 21, 31, ...
              in "${workspace}, monitor:${monitorName}${optionalString isDefault ", default:true"}"
            )
            # we generate a list of 10 elements for each monitor. We have to add 1 each time since genList starts indexing at 0.
            # also, we add the monitorIndex * 10 to get 10 workspaces for each individual monitor.
            (genList (i: i + 1 + (10 * monitorIndex)) 10)
          ))
          # our attrSet of different monitors
          (attrNames monitors)))
      # These are my two special workspaces
      ++ [
        "special:nixos, decorate:false"
        "special:keepassxc, decorate:false"
        "special:audio, decorate:false"
      ];
  };
}
