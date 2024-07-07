const { Gtk } = imports.gi;
import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';
const { execAsync, exec } = Utils;
const { Box, Button, EventBox, Icon, Label, Scrollable } = Widget;
import SidebarModule from './module.js';
import { MaterialIcon } from '../../../lib/materialicon.js';
import { setupCursorHover } from '../../../lib/cursorhover.js';

Gtk.IconTheme.get_default().append_search_path(`${App.configDir}/assets`);
const distroID = exec(`bash -c 'cat /etc/os-release | grep "^ID=" | cut -d "=" -f 2'`).trim();
const isDebianDistro = (distroID == 'linuxmint' || distroID == 'ubuntu' || distroID == 'debian' || distroID == 'zorin' || distroID == 'pop' || distroID == 'raspbian' || distroID == 'kali' || distroID == 'elementary');
const isArchDistro = (distroID == 'arch' || distroID == 'endeavouros');
const hasFlatpak = !!exec(`bash -c 'command -v flatpak'`);

const scripts = [
    {
        icon: 'nixos-symbolic',
        name: 'Trim system generations to 5',
        command: `sudo ${App.configDir}/scripts/quickscripts/nixos-trim-generations.sh 5 0 system`,
        enabled: distroID == 'nixos',
    },
    {
        icon: 'nixos-symbolic',
        name: 'Trim home manager generations to 5',
        command: `${App.configDir}/scripts/quickscripts/nixos-trim-generations.sh 5 0 home-manager`,
        enabled: distroID == 'nixos',
    },
    {
        icon: 'ubuntu-symbolic',
        name: 'Update packages',
        command: `sudo apt update && sudo apt upgrade -y`,
        enabled: isDebianDistro,
    },
    {
        icon: 'fedora-symbolic',
        name: 'Update packages',
        command: `sudo dnf upgrade -y`,
        enabled: distroID == 'fedora',
    },
    {
        icon: 'arch-symbolic',
        name: 'Update packages',
        command: `sudo pacman -Syyu`,
        enabled: isArchDistro,
    },
    {
        icon: 'flatpak-symbolic',
        name: 'Uninstall unused flatpak packages',
        command: `flatpak uninstall --unused`,
        enabled: hasFlatpak,
    },
];

export default () => SidebarModule({
    icon: MaterialIcon('code', 'norm'),
    name: 'Quick scripts',
    child: Box({
        vertical: true,
        className: 'spacing-v-5',
        children: scripts.map((script) => {
            if (!script.enabled) return null;
            const scriptStateIcon = MaterialIcon('not_started', 'norm');
            return Box({
                className: 'spacing-h-5 txt',
                children: [
                    Icon({
                        className: 'sidebar-module-btn-icon txt-large',
                        icon: script.icon,
                    }),
                    Label({
                        className: 'txt-small',
                        hpack: 'start',
                        hexpand: true,
                        label: script.name,
                        tooltipText: script.command,
                    }),
                    Button({
                        className: 'sidebar-module-scripts-button',
                        child: scriptStateIcon,
                        onClicked: () => {
                            App.closeWindow('sideleft');
                            execAsync([`bash`, `-c`, `foot fish -C "${script.command}"`]).catch(print)
                                .then(() => {
                                    scriptStateIcon.label = 'done';
                                })
                        },
                        setup: setupCursorHover,
                    }),
                ],
            })
        }),
    })
});