# nichts
My personal collection of NixOS configuration files
# License 
No Idea at this point 
# Flake structure: 
```
.
├── assets
│   └── wallpapers # My wallpapers
├── flake.lock # Lock file
├── flake.nix # Flake inputs
├── hosts # My different hosts
│   ├── default.nix # Where the different hosts are specified
│   └── vali
│       └── mars # My main computer 
│           ├── configuration.nix # Main configuration file 
│           ├── default.nix
│           ├── hardware-configuration.nix # Hardware config for my system
│           ├── profile.nix # importing different system options
│           └── programs.nix # Installed Programs
├── lib
│   ├── default.nix
│   └── options.nix # For the future: some options to set if I need them
├── LICENSE
├── modules
│   ├── cli
│   │   ├── default.nix
│   │   ├── fish.nix # Fish shell config
│   │   ├── neovim.nix # Incomplete neovim config
│   │   └── nh.nix # nix helper config
│   ├── default.nix
│   ├── editors # My different editors
│   │   ├── default.nix 
│   │   ├── emacs.nix # Emacs config
│   │   ├── helix.nix # Helix config
│   │   ├── kakoune.nix # Kakoune config
│   │   └── neovim.nix # Neovim config
│   ├── gui
│   │   ├── anyrun # My Anyrun config
│   │   │   ├── anyrun.nix # Anyrun config
│   │   │   ├── default.nix
│   │   │   └── style.css # Anyrun styling
│   │   ├── default.nix
│   │   ├── foot.nix # Foot config
│   │   ├── gtk.nix # Gtk config
│   │   ├── kitty.nix # Kitty config
│   │   ├── minecraft.nix # Minecraft config
│   │   ├── mpv.nix # Mpv config
│   │   ├── qt.nix # Qt config
│   │   ├── rofi.nix # Rofi config
│   │   ├── schizofox.nix # Schizofox config
│   │   ├── spicetify.nix # Spotify config
│   │   ├── steam.nix # Steam config
│   │   ├── stylix.nix # Stylix config
│   │   ├── vesktop.nix # Discord config
│   │   ├── vivado.nix # Vivado my beloved <3
│   │   ├── waybar.nix # Waybar config
│   │   └── zathura.nix # Zathura config
│   ├── other
│   │   ├── default.nix
│   │   ├── home-manager.nix # Home Manager config
│   │   ├── system.nix # System config
│   │   └── xdg.nix # XDG config
│   ├── services
│   │   ├── default.nix
│   │   ├── dunst.nix # Dunst Daemon config
│   │   ├── greetd.nix # Greetd greeter config
│   │   ├── pipewire.nix # Audio config
│   │   └── ssh.nix # Ssh config
│   ├── tui
│   │   ├── btop.nix # btop config
│   │   ├── default.nix
│   │   ├── ncmpcpp.nix # Ncmpcpp config
│   │   ├── newsboat.nix # Newsboat config
│   │   └── yazi.nix # Yazi config
│   └── wms # My different Window Managers
│       ├── wayland # Wayland Compositors
│       │   ├── default.nix
│       │   ├── hypr # Hypr* stuff
│       │   │   ├── default.nix
│       │   │   ├── idle.nix # Hypridle config
│       │   │   ├── land.nix # Hyprland config
│       │   │   ├── lock.nix # Hyprlock config
│       │   │   └── paper.nix # Hyprpaper config
│       │   ├── niri # The Miri compositor
│       │   │   ├── config.nix # Niri config
│       │   │   └── default.nix
│       │   ├── services.nix # Enabled services I need in wayland
│       │   └── variables.nix # Wayland system variables
│       └── x # My X window managers 
│           ├── awesome # Awesome window manager
│           │   ├── awesome.nix # Awesome config
│           │   └── rc.lua #  Awesome config file
│           └── default.nix
├── notes.md
├── options # Options for my system
│   ├── boot
│   │   └── grub-boot.nix # Grub config
│   ├── common
│   │   ├── bluetooth.nix # Bluetooth
│   │   ├── gpu
│   │   │   └── nvidia.nix # Fuck Nvidia
│   │   ├── networking.nix # Networking config
│   │   ├── pin-registry.nix # No idea
│   │   └── preserve-system.nix # No idea
│   └── desktop
│       ├── fonts.nix # My fonts
│       └── monitors.nix # Monitor config
├── overlay.nix # Overlays
└── README.md # This file # This file
```
# credits
*heavily* inspired by https://git.jacekpoz.pl/jacekpoz/niksos.git !
Sioodmy: https://github.com/sioodmy/dotfiles
Heinrik Lissner: https://github.com/hlissner/dotfiles/
Lokasku: https://github.com/lokasku/nix-config
NotaShelf: https://github.com/notashelf/Nyx
Wallpapers: https://github.com/zhichaoh/catppuccin-wallpapers?tab=readme-ov-file
