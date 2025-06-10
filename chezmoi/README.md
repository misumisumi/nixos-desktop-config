# chezmoi's dotfiles for Linux, macOS, Windows...

Cross-platform dotfiles using [chezmoi](https://www.chezmoi.io).

## Why I use chezmoi.

nix is a highly reproducible package manager that declaratively specifies dependencies and build procedures.
While it offers high reproducibility, it also has some drawbacks, such as being incompatible with Windows and requiring more disk space due to treating packages with different dependency versions as distinct entities.
Additionally, installing nix requires administrator privileges to create the `/nix/store` directory, making it difficult to use in restricted environments like company-provided PCs or HPCs.

However, in restricted environments, there is often no need for system-wide administration; it is sufficient to build a minimal development environment within the user environment.
In other words, it is sufficient to manage only the dotfiles.

**chezmoi** is a dotfile manager with the following features:

- Supports multiple platforms, including Windows
- Absorbs differences between machines using Go templates
- Imports secrets using various password managers
- Imports from archive files
- Encrypts files using GPG or age
- Executes custom scripts for additional processing

In particular, script execution enables flexible operations such as declarative package installation and privileged operations in system space.
By combining it with non-privileged package managers (unix=`mise`, windows=`scoop`), it is possible to set up the same development environment even in a restricted environments.

## Settings

### `.chezmoidata`

`chezmoi` can change settings for each environment using `.chezmoidata.$FORMAT`
This repository has settings for each OS, host machine, and user under `.chezmoidata`.
See each files in [.chezmoidata](.chezmoidata).

### `.chezmoiscripts`

`chezmoi` support user script when you run `chezmoi apply`.  
By writing `<os>.hosts.<hostname>.owner = true` in `.chezmoidata/hosts/*`, you can execute scripts that require administrator privileges (`.chezmoiscripts/**/*_admin_*`).

`<os>.hosts.<hostname>.owner = true`とすることで、`.chezmoiscripts`以下の管理者権限を必要とするスクリプト(`*_admin_*`)を実行可能です。

## Windows

### Installation

```ps1
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
$env:PATH = "$env:USERPROFILE\scoop\apps\git\current\mingw64\bin;<span class="math-inline">env\:PATH"
iex "&\{</span>(irm '[https://get.chezmoi.io/ps1](https://get.chezmoi.io/ps1)')} -b '~/.local/bin' -- init --apply misumisumi/nixos-desktop-config"
```

### Package Manager

Support declarative package installation using following package managers.
See [.chezmoidata/users/sumi.toml](.chezmoidata/users/sumi.toml) for detail.

| pkg manager |       admin        |
| :---------: | :----------------: |
|   winget    | yes (partially no) |
| chocolatey  | yes (partially no) |
|    scoop    |         no         |

### Tips

#### Installing with a Local Account

- If you sign in with an Microsoft account during the initial setup, a user account will be created based on that account name.
- To create a custom user account, you'll need to install using a local account.
- However, Windows 11 requires an internet connection and Microsoft account sign-in by default. To bypass this,
- During installation, press `ctrl+shift+F10` to open a command prompt, run the following command, and then disconnect from the network after the automatic restart to proceed with a local account:

```bat
oobe\bypassnro
```

- How to do something similar in ISOs with bypassnro removed
  1.  Shift+F10 -> regedit
  2.  `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\OOBE`
  3.  `HideOnlineAccountScreens` -> 1

#### How to make one storage bootable on both VM and bare metal

1. Copy `$env:USERPROFILE/.local/share/startup/kvm_storage_boot.ps1` to `\Windows\System32\GroupPolicy\Machine\Scripts\Startup`.
2. Open the Group Policy Editor by typing `gpedit.msc` into the `win+r` dialog.
3. Navigate to `computer > administrative > windows components > windows > scripts > startup > powershell scripts`.
4. Set the script name to `kvm_storage_boot.ps1` and the options to `storahci vioscsi stornvme viostor iaStorAVC iaStorV nvstor storflt storvsc`.

- Reference: [Cannot boot on bare metal windows anymore after importing in VM (libvirt)](https://www.reddit.com/r/VFIO/comments/kkoyvj/cannot_boot-on-bare-metal-windows-anymore-after/)

## macOS & Linux

### Installation

- Please check executes `git`

```sh
# install homebrew (if need)
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# install chezmoi and apply dotfiles
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply "misumisumi/nixos-desktop-config"
```

### Package Manager

Support declarative package installation using mise and homebrew.
You can also use the distribution standard package manager.
See [.chezmoidata/users/sumi.toml](.chezmoidata/users/sumi.toml) for detail.

|     pkg manager      |             admin              |
| :------------------: | :----------------------------: |
|         mise         |               no               |
|       homebrew       | no (required for installation) |
| apt, pacman, yum ... |              yes               |

### build requirements (Ubuntu)

- `build-essential`
- `git`
- `nasm` # for ffmpeg
- `ncurses-dev bison` # for tmux
- [ruby wiki#suggested-build-environment](https://github.com/rbenv/ruby-build/wiki#suggested-build-environment) # for ruby
