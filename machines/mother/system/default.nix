{ colorTheme, ... }:
with builtins;
{
  imports = [
    ../../../apps/color-theme/system/${head (split "-" colorTheme)}
    ../../../apps/system/documentation
    ../../../apps/system/nix-ld
    ../../../apps/system/pkgs
    ../../../apps/system/printer
    ../../../apps/system/programs
    ../../../apps/system/services
    ../../../apps/system/sops
    ../../../apps/system/ssh
    ../../../apps/system/steam
    ../../../apps/system/usbip
    ../../../apps/system/virtualsmartcard
    ../../../apps/system/wireshark
    ../../../apps/system/wm/qtile
    ../../../apps/system/yubikey
    ../../../settings/system
    ../../../settings/system/bluetooth
    ../../../settings/system/musnix
    ../../../settings/system/pipewire
    ../../init
    ../../init/zfs.nix
    ./disks/rootfs.nix
    ./disks/system.nix
    ./gpu.nix
    ./hardware-configuration.nix
    ./network.nix
    ./persist/nix-daemon.nix
    ./persist/persistence.nix
    ./persist/snapper.nix
    ./sops.nix
    ./system.nix
    ./virtualisation.nix
  ];
  security.pki.certificates = [
    ''
      -----BEGIN CERTIFICATE-----
      MIICbDCCAfOgAwIBAgIBATAKBggqhkjOPQQDAzB3MQswCQYDVQQGEwJKUDEOMAwG
      A1UECAwFVG9reW8xGDAWBgNVBAoMD1Byb2plY3QgUXVpbnRldDEgMB4GA1UECwwX
      UHJvamVjdCBRdWludGVkIFJvb3QgQ0ExHDAaBgNVBAMME3Jvb3RjYS5xdWludGV0
      LmhvbWUwHhcNMjYwNTA2MTA1MjQ5WhcNMzYwNTAzMTA1MjQ5WjB3MQswCQYDVQQG
      EwJKUDEOMAwGA1UECAwFVG9reW8xGDAWBgNVBAoMD1Byb2plY3QgUXVpbnRldDEg
      MB4GA1UECwwXUHJvamVjdCBRdWludGVkIFJvb3QgQ0ExHDAaBgNVBAMME3Jvb3Rj
      YS5xdWludGV0LmhvbWUwdjAQBgcqhkjOPQIBBgUrgQQAIgNiAAQ7fJ87vNHqQr1n
      fd3u9OqKb2U4c8/w50PQgoJmkMahhUqDjWlneI3hxNXmxxLLwW3H32jkgNs+IEhh
      ka+z5ktMeyiIQBB/BSaX23tCudsUxsAe0wwxOH5EUkkcWc5QPsajUzBRMB0GA1Ud
      DgQWBBTc+TIxsGwjAdtRfY1b+UW6u0sptjAfBgNVHSMEGDAWgBTc+TIxsGwjAdtR
      fY1b+UW6u0sptjAPBgNVHRMBAf8EBTADAQH/MAoGCCqGSM49BAMDA2cAMGQCMHNY
      5BpQlcxNRplkiptfolopYaAvjAEF+cLxvvaE7QvJygvW2kkZSjJFsEBltLpkxQIw
      XCmKAr/JY/pOYPHcP6hWufT9B2zpr1LUSv9LdWul7NE+rdM90IJsvDgcYhJ+BMmo
      -----END CERTIFICATE-----
    ''
  ];
}
