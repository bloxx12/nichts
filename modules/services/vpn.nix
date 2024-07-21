{pkgs, ...}: {
  services.openvpn.servers = {
    #    air = {
    #      config = ''
    #        config /home/vali/Documents/AirVPN_Netherlands_UDP-443-Entry3.ovpn
    #        script-security 2
    #        up ${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved
    #        down ${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved
    #      '';
    #    };
  };
}
