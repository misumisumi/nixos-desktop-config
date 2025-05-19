{ user, ... }:
{
  environment.persistence."/nix/persist" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/etc/ssh" # system ssh dir
      "/var"
    ];
    files = [
      "/etc/machine-id"
    ];
    users.${user} = {
      directories = [
        ".config"
        ".local/share"
        ".mozilla"
        ".thunderbird"
        ".vst3"
        ".zinit"
        ".zoom"
        ".zotero"
        "Unity"
        "Documents"
        "Music"
        "Pictures"
        "Templates"
        "Videos"
        "Workspace"
        "Zotero"
        {
          directory = ".gnupg";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }
        # {
        #   directory = ".nixops";
        #   mode = "0700";
        # }
      ];
      # files = [ ];
    };
  };
  environment.persistence."/nix/persist-alt" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/root/.local/share/nix"
    ];
    users.${user} = {
      directories = [
        ".cache"
        ".local/share/Steam"
        ".local/state"
        "Downloads"
        "go"
      ];
    };
  };
}
