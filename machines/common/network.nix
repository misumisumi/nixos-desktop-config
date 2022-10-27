{ lib, ... }:

{
  systemd = {
    network = {
      enable = true;
      wait-online = {
        timeout = 0;    # Disable wait online
      };
    };
  };

  services = {
    nscd = {
      enable = false;
    };
    resolved = {
      enable = true;
      fallbackDns = [
        "192.168.1.40"
        "1.1.1.1"
        "2606:4700:4700::1111"
        "8.8.8.8"
        "2001:4860:4860::8888"
      ];
    };
  };

  networking = {
    useDHCP = lib.mkDefault false;    # Setting each network interafces
    wireless = {
      networks = {
        "ASUS_RT-AC85U_5G" = {
          pskRaw = "5376215bf67d31cac4df819ad719699b95f5e1c6986ffe84b0237c895caf23f5";
          priority = 10;
        };

        "SHIRASAGI_PR@NHK" = {
          pskRaw = "a529f89028eada364c9c2193eb5a098e19fb98c10e68b43e3a8d7d45bbac79b5";
          priority = 5;
        };

        "shisha-pucapuca-himeji" = {
          pskRaw = "b756c71f35a230c537a0765480eed3eb16a7399cc58a988eeab18701f866273e";
          priority = 1;
        };
      };
    };
  };

  system.nssModules = lib.mkForce [];
}
