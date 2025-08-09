{ pkgs, ... }:
{
  sops.secrets = {
    "chap-secrets" = {
      path = "/etc/ppp/chap-secrets";
      sopsFile = ../../../../../sops/system/ppp/chap-secrets;
      format = "binary";
      mode = "0600";
    };
    "pap-secrets" = {
      path = "/etc/ppp/pap-secrets";
      sopsFile = ../../../../../sops/system/ppp/pap-secrets;
      format = "binary";
      mode = "0600";
    };
  };
  services = {
    xl2tpd = {
      enable = true;
      extraXl2tpOptions = ''
        [global]
        debug avp = yes
        debug network = yes
        debug packet = yes
        debug state = yes
        debug tunnel = yes
        max retries = 6
      '';
    };
    strongswan-swanctl = {
      enable = true;
      # works without this config but add it just in case
      strongswan.extraConfig = ''
        charon {
          install_routes = yes
          install_virtual_ip = yes
        }
      '';
    };
  };
  system.activationScripts.link-ppp-dir.text = ''
    [ -d /etc/xl2tpd/ppp ] && rm -rf /etc/xl2tpd/ppp
    ln -sf /etc/ppp /etc/xl2tpd/ppp
  '';
  environment.etc = {
    "ppp/ip-pre-up" = {
      mode = "0700";
      source = "${pkgs.ppp-scripts}/etc/ppp/ip-pre-up";
    };
    "ppp/ip-up" = {
      mode = "0700";
      source = "${pkgs.ppp-scripts}/etc/ppp/ip-up";
    };
    "ppp/ip-down" = {
      mode = "0700";
      source = "${pkgs.ppp-scripts}/etc/ppp/ip-down";
    };
    "ppp/ipv6-up" = {
      mode = "0700";
      source = "${pkgs.ppp-scripts}/etc/ppp/ipv6-up";
    };
    "ppp/ipv6-down" = {
      mode = "0700";
      source = "${pkgs.ppp-scripts}/etc/ppp/ipv6-down";
    };
    "ppp/ip-up.d/0000usepeerdns" = {
      mode = "0700";
      source = "${pkgs.ppp-scripts}/etc/ppp/ip-up.d/0000usepeerdns";
    };
    "ppp/ip-down.d/0000usepeerdns" = {
      mode = "0700";
      source = "${pkgs.ppp-scripts}/etc/ppp/ip-down.d/0000usepeerdns";
    };
  };
}
