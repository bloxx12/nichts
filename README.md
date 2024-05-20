# nichts
My personal collection of NixOS configuration files
# License 
The whole project is licensed under GPL-3, with excpetion of the *lib* folder, since I do not know the copyright of some of the wallpapers. 

# Flake structure: 
```
.
├── assets
│   └── wallpapers # My wallpapers
├── flake.lock # Lock file
├── flake.nix # Flake inputs
├── hosts
│   ├── default.nix
│   └── vali
│       └── mars
│           ├── awesome
│           │   └── awesome.nix
│           ├── configuration.nix
│           ├── default.nix
│           ├── hardware-configuration.nix
│           ├── profile.nix
│           └── programs.nix
├── lib
│   ├── default.nix
│   └── options.nix
├── LICENSE
├── modules
│   ├── cli
│   │   ├── default.nix
│   │   ├── fish.nix
│   │   ├── neovim.nix
│   │   └── nh.nix
│   ├── default.nix
│   ├── editors
│   │   ├── default.nix
│   │   └── emacs.nix
│   ├── gui
│   │   ├── anyrun
│   │   │   ├── anyrun.nix
│   │   │   ├── default.nix
│   │   │   └── style.css
│   │   ├── default.nix
│   │   ├── emacs
│   │   │   ├── default.nix
│   │   │   ├── doom.d
│   │   │   └── emacs.nix
│   │   ├── firefox.nix
│   │   ├── foot.nix
│   │   ├── gtk.nix
│   │   ├── kakoune
│   │   │   ├── default.nix
│   │   │   ├── kak-lsp.toml
│   │   │   ├── kakoune.nix
│   │   │   ├── kakrc
│   │   │   └── starship.toml
│   │   ├── kakoune.nix
│   │   ├── kitty.nix
│   │   ├── minecraft.nix
│   │   ├── mpv.nix
│   │   ├── qt.nix
│   │   ├── rofi.nix
│   │   ├── schizofox.nix
│   │   ├── spicetify.nix
│   │   ├── steam.nix
│   │   ├── stylix.nix
│   │   ├── vesktop.nix
│   │   ├── vivado.nix
│   │   ├── waybar.nix
│   │   └── zathura.nix
│   ├── other
│   │   ├── default.nix
│   │   ├── home-manager.nix
│   │   ├── system.nix
│   │   └── xdg.nix
│   ├── services
│   │   ├── default.nix
│   │   ├── dunst.nix
│   │   ├── greetd.nix
│   │   ├── pipewire.nix
│   │   └── ssh.nix
│   ├── tui
│   │   ├── btop.nix
│   │   ├── config
│   │   ├── default.nix
│   │   ├── helix.nix
│   │   ├── ncmpcpp.nix
│   │   ├── neovim.nix
│   │   ├── newsboat.nix
│   │   └── yazi.nix
│   └── wms
│       ├── wayland
│       │   ├── default.nix
│       │   ├── hypr
│       │   │   ├── default.nix
│       │   │   ├── idle.nix
│       │   │   ├── land.nix
│       │   │   ├── lock.nix
│       │   │   └── paper.nix
│       │   ├── niri
│       │   │   ├── config.nix
│       │   │   └── default.nix
│       │   ├── services.nix
│       │   └── variables.nix
│       └── x
│           ├── awesome
│           │   ├── awesome.nix
│           │   └── rc.lua
│           └── default.nix
├── notes.md
├── options
│   ├── boot
│   │   └── grub-boot.nix
│   ├── common
│   │   ├── bluetooth.nix
│   │   ├── gpu
│   │   │   └── nvidia.nix
│   │   ├── networking.nix
│   │   ├── pin-registry.nix
│   │   └── preserve-system.nix
│   └── desktop
│       ├── fonts.nix
│       └── monitors.nix
├── overlay.nix
└── README.md
```
# credits
*heavily* inspired by https://git.jacekpoz.pl/jacekpoz/niksos.git !

Wallpapers: https://github.com/zhichaoh/catppuccin-wallpapers?tab=readme-ov-file
