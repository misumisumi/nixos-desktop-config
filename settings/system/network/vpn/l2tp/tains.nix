{ pkgs, ... }:
{
  services = {
    xl2tpd.extraXl2tpOptions =
      let
        # NOTE: SubIDを変更したらここも変更する必要あり
        tains-ppp-options = pkgs.writeText "tains-ppp-options" ''
          ipparam tains:130.34.40.195
          user "dizzy6572@student.tohoku.ac.jp"
          name "dizzy6572@student.tohoku.ac.jp"
          nodetach
          noauth
          usepeerdns
          noipdefault
          nodefaultroute
          noccp
          hide-password
          debug
          lcp-echo-failure 0
          lcp-echo-interval 0
          logfile /var/log/xl2tpd.log
          mtu 1400
          mru 1400
        '';
      in
      ''
        [lac tains]
        lns = 130.34.40.195
        require pap = yes
        require chap = yes
        require authentication = yes
        max redials = 6
        ppp debug = yes
        pppoptfile = ${tains-ppp-options}
      '';
    strongswan-swanctl.swanctl = {
      connections.tains = {
        remote_addrs = [
          "tuvpn.tohoku.ac.jp"
          "130.34.40.195"
        ];
        encap = true;
        remote."tuvpn" = {
          auth = "psk";
          id = "10.254.6.35";
        };
        local."psk" = {
          auth = "psk";
        };

        children = {
          tains = {
            mode = "transport";
            esp_proposals = [
              "aes256-sha1"
              "aes128-sha1"
              "3des-sha1"
            ];
          };
        };
        version = 1;
        proposals = [
          "aes256-sha2_256-modp2048"
          "aes256-sha2_256-modp1536"
          "aes256-sha2_256-modp1024"
          "aes256-sha1-modp2048"
          "aes256-sha1-modp1536"
          "aes256-sha1-modp1024"
          "aes256-sha1-ecp384"
          "aes128-sha1-modp1024"
          "aes128-sha1-ecp256"
          "3des-sha1-modp2048"
          "3des-sha1-modp1024"
        ];
      };
      secrets.ike."tains" = {
        secret = "vpnipsec";
        id."tains" = "10.254.6.35";
      };
    };
  };
  systemd.services."vpn-tains" = {
    description = "Connect to TAINS VPN";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStartPre = "${pkgs.strongswan}/bin/swanctl --initiate --child tains";
      ExecStart = "${pkgs.xl2tpd}/bin/xl2tpd-control -d -c /run/xl2tpd/control connect-lac tains";
      ExecStop = "${pkgs.xl2tpd}/bin/xl2tpd-control -c /run/xl2tpd/control disconnect-lac tains";
      ExecStopPost = "${pkgs.strongswan}/bin/swanctl --terminate --child tains";
    };
  };
  environment.etc = {
    "ppp/ip-up.d/10-tains" = {
      mode = "0700";
      text = ''
        CONNECTION_NAME=$(echo "$6" | ${pkgs.gawk}/bin/awk -F':' '{ print $1 }')
        CONNECTION_ADDR=$(echo "$6" | ${pkgs.gawk}/bin/awk -F':' '{ print $2 }')

        if [ "$CONNECTION_NAME" != "tains" ]; then
          echo "Not a tains connection, skipping route addition."
          exit 0
        fi

        DEFAULT_ROUTE_INFO=$(${pkgs.iproute2}/bin/ip route show default | ${pkgs.gnugrep}/bin/grep -oP 'via \K[\d\.]+' | ${pkgs.coreutils}/bin/head -n 1)
        DEFAULT_DEVICE=$(${pkgs.iproute2}/bin/ip route show default | ${pkgs.gnugrep}/bin/grep -oP 'dev \K\S+' | ${pkgs.coreutils}/bin/head -n 1)
        echo "Default route info: $DEFAULT_ROUTE_INFO, Default device: $DEFAULT_DEVICE"

        if [ -z "$DEFAULT_ROUTE_INFO" ] || [ -z "$DEFAULT_DEVICE" ]; then
            echo "No default route or device found."
            exit 0
        fi

        # add a static route to the specified network via the default gateway
        ${pkgs.iproute2}/bin/ip route add "$CONNECTION_ADDR" via "$DEFAULT_ROUTE_INFO" dev "$DEFAULT_DEVICE" proto static metric 50
        ${pkgs.iproute2}/bin/ip route add default dev "$1" proto static metric 50

        ${pkgs.systemd}/bin/resolvectl dns "$1" "$DNS1" "$DNS2"
      '';
    };
    "ppp/ip-down.d/10-tains" = {
      mode = "0700";
      text = ''
        CONNECTION_NAME=$(echo "$6" | ${pkgs.gawk}/bin/awk -F':' '{ print $1 }')
        CONNECTION_ADDR=$(echo "$6" | ${pkgs.gawk}/bin/awk -F':' '{ print $2 }')

        if [ "$CONNECTION_NAME" != "tains" ]; then
          echo "Not a tains connection, skipping route addition."
          exit 0
        fi

        DEFAULT_ROUTE_INFO=$(${pkgs.iproute2}/bin/ip route show default | ${pkgs.gnugrep}/bin/grep -oP 'via \K[\d\.]+' | ${pkgs.coreutils}/bin/head -n 1)
        DEFAULT_DEVICE=$(${pkgs.iproute2}/bin/ip route show default | ${pkgs.gnugrep}/bin/grep -oP 'dev \K\S+' | ${pkgs.coreutils}/bin/head -n 1)
        echo "Default route info: $DEFAULT_ROUTE_INFO, Default device: $DEFAULT_DEVICE"

        if [ -z "$DEFAULT_ROUTE_INFO" ] || [ -z "$DEFAULT_DEVICE" ]; then
            echo "No default route found."
            exit 0
        fi

        # add a static route to the specified network via the default gateway
        ${pkgs.iproute2}/bin/ip route delete "$CONNECTION_ADDR" via "$DEFAULT_ROUTE_INFO" dev "$DEFAULT_DEVICE" proto static metric 50
      '';
    };
  };
}
