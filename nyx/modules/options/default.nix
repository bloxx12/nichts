{
  imports = [
    ./docs # internal module system documentation and linking
    ./device # device-specific declarations, hardware-specific
    ./meta # internal read-only system manifests for easy access to system details
    ./profiles # profiles allow the system to batch enable programs without hassle
    ./system # system-level declarations, software-specific
    ./theme # theme packages and configurations
    ./usrEnv # user environment, such as main system user or

    ./removed.nix # options that have been fully deprecated
    ./renamed.nix # options that have been moved or relocated. Will throw a warning if they are used
  ];
}
