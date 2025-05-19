{
  config,
  lib,
  user,
  ...
}:
{
  # boot.initrd.postResumeCommands = lib.mkAfter ''
  #   mkdir /btrfs_tmp
  #   mount /dev/root_vg/root /btrfs_tmp
  #   if [[ -e /btrfs_tmp/root ]]; then
  #       mkdir -p /btrfs_tmp/old_roots
  #       timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
  #       mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
  #   fi

  #   delete_subvolume_recursively() {
  #       IFS=$'\n'
  #       for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
  #           delete_subvolume_recursively "/btrfs_tmp/$i"
  #       done
  #       btrfs subvolume delete "$1"
  #   }

  #   for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
  #       delete_subvolume_recursively "$i"
  #   done

  #   btrfs subvolume create /btrfs_tmp/root
  #   umount /btrfs_tmp
  # '';
  systemd.services."persist-home-create-root-paths" =
    let
      persistentHomesRoot = "/persistent";

      listOfCommands = lib.mapAttrsToList (
        _: user:
        let
          userHome = lib.escapeShellArg (persistentHomesRoot + user.home);

        in
        ''
          if [[ ! -d ${userHome} ]]; then
              echo "Persistent home root folder '${userHome}' not found, creating..."
              mkdir -p --mode=${user.homeMode} ${userHome}
              chown ${user.name}:${user.group} ${userHome}
          fi
        ''
      ) (lib.filterAttrs (_: user: user.createHome) config.users.users);

      stringOfCommands = lib.concatLines listOfCommands;
    in
    {
      script = stringOfCommands;
      unitConfig = {
        Description = "Ensure users' home folders exist in the persistent filesystem";
        PartOf = [ "local-fs.target" ];
        # The folder creation should happen after the persistent home path is mounted.
        After = [ "persist-home.mount" ];
      };

      serviceConfig = {
        Type = "oneshot";
        StandardOutput = "journal";
        StandardError = "journal";
      };

      # [Install]
      wantedBy = [ "local-fs.target" ];

    };
  environment.persistence."/persistent" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/var/db/sudo"
      "/var/lib/bluetooth"
      "/var/lib/cni/networks"
      "/var/lib/containers"
      "/var/lib/incus"
      "/var/lib/libvirt"
      "/var/lib/lxc"
      "/var/lib/lxcfs"
      "/var/lib/lxd"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/systemd/timers"
      "/var/lib/waydroid"
      "/var/lib/xppenconf"
      "/var/log"
    ];
    files = [
      "/root.local/share/nix/trusted-settings.json"
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/var/lib/cups/printers.conf"
      "/var/lib/cups/subscriptions.conf"
      "/var/lib/sops-nix/key.txt"
    ];
    users.${user} = {
      directories = [
        ".cache/fontconfig"
        ".cache/mesa_shader_cache"
        ".cache/mesa_shader_cache_db"
        ".config/vivaldi"
        ".gnupg"
        ".local/share/Steam"
        ".local/share/containers"
        ".local/share/direnv"
        ".local/share/keyrings"
        ".local/share/nvim"
        ".local/share/qtile/wallpapers"
        ".local/share/systemd/timers"
        ".local/state/wireplumber"
        ".mozilla/firefox"
        ".ssh"
        ".vst3"
        ".zinit"
        ".zotero/zotero"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Templates"
        "Unity"
        "Videos"
        "Zotero"
        "workspace"
        # ".nixops"
      ];
      files = [
        ".bash_history"
        ".local/share/nix/trusted-settings.json"
        ".zsh_history"
      ];
    };
  };
}
