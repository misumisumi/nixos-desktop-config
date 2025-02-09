# chezmoi's dotfiles for Linux, MacOS, Windows...

[chezmoi](https://www.chezmoi.io)を用いたマルチプラットフォーム対応のdotfiles.

## Why I use chezmoi.

nixは依存関係とビルト手順を宣言的に明記することで高い再現性を持つパッケージマネージャです。
高い再現性を持つ反面、windowsに非対応、同じパッケージでも依存元バージョンの違いで異なるパッケージとして扱われるため、より多くのディスク容量を要求する傾向にあるなど問題もあります。
nixのインストールについても`/nix/store`を作成する都合上、管理者権限を要求します。
そのため、会社支給PCやHPCといった制限された環境で使うことが困難です。

しかし制限された環境では、そもそもシステム管理を行う必要は無く、ユーザー環境下で最低限の開発環境を構築できれば良いと考えられます。
つまり、dotfilesの管理だけ行えば良いのです。

**chezmoi**はdotfilesマネージャであり、次のような特長があります。

- windowsを含めたマルチプラットフォームに対応
- Goテンプレートによるマシン間の差異の吸収
- 各パスワードマネージャを用いたシークレットのインポート
- アーカイブファイルからのインポート
- GPGやageを用いたファイル暗号化
- スクリプト実行によるユーザー定義の追加処理

特にスクリプト実行により宣言的なパッケージインストールや特権付与によるシステム空間での処理といった柔軟な運用が可能になります。
特権を必要としないパッケージマネージャー(unix=`mise`, windows=`scoop`)の併用することで、制限された環境でも同じ開発環境を整えることが可能です。

## 設定

### `.chezmoidata`

`chezmoi`は、`.chezmoidata.$FORMAT`を使って環境毎に設定を変更することが可能です。  
このリポジトリでは`.chezmoidata`以下に、OS・ホストマシン・ユーザー毎の設定を配置しています。  
詳しくは各ファイルを参照してください。

### `.chezmoiscripts`

`chezmoi`は、`chezmoi apply`時にスクリプトを実行可能です。  
`.chezmoidata/hosts/*`に`<os>.hosts.<hostname>.owner = true`を記載することで 、`.chezmoiscripts`以下の管理者権限を必要とするスクリプト(`*_admin_*`)を実行可能です。

## Windows

### インストール

```ps1
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
$env:PATH = "$env:USERPROFILE\scoop\apps\git\current\mingw64\bin;$env:PATH"
iex "&{$(irm 'https://get.chezmoi.io/ps1')} -b '~/.local/bin' -- init --apply misumisumi/nixos-desktop-config"
```

### パッケージマネージャ

次のパッケージマネージャを使った宣言的なパッケージインストールをサポートしています。
詳しくは[.chezmoidata/users/sumi.toml](.chezmoidata/users/sumi.toml)をご覧ください。

| pkg manager |      admin      |
| :---------: | :-------------: |
|   winget    | yes (partially) |
| chocolatey  | yes (partially) |
|    scoop    |       no        |

### Tips

#### ローカルアカウントでインストール

- 初回設定時にMSアカウントでサインインしてしまうとアカウント名に基づいたユーザー名が登録されてしまう
- 任意の名前を登録したい場合はローカルアカウントでインストールする必要がある
- ただし、windows11ではインターネットの接続+MSアカウントでのログインが必須になっているためバイパスする必要がある
- インストール時に`ctrl+shift+F10`でコマンドプロンプトを開き、次のコマンドを実行し自動再起動後、ネットワークを切断するとローカルアカウントで進められる

```bat
oobe\bypassnro
```

#### 1つのストレージをVMとベアメタルで起動可能にする方法

- windowsは起動時に使わなかったストレージドライバーを次回起動時に不要としてマークする
- そのため、virtio (VM)で起動後にnvme (ベアメタル)で起動できない
- 次の手順でマークを解除するスクリプトを配置することでこれを回避する

1. `$env:USERPROFILE/.local/share/startup/kvm_storage_boot.ps1`を`\Windows\System32\GroupPolicy\Machine\Scripts\Startup`にコピー
2. `win+r`で`gpedit.msc`と入力し、グループポリシーエディターを起動
3. `computer > administrative > windows components > windows > scripts > startup > powershell scripts`
4. スクリプト名に`kvm_storage_boot.ps1` を、オプションに`storahci vioscsi stornvme viostor iaStorAVC iaStorV nvstor storflt storvsc`を指定

- 参考: [Cannot boot on bare metal windows anymore after importing in VM (libvirt)](https://www.reddit.com/r/VFIO/comments/kkoyvj/cannot_boot_on_bare_metal_windows_anymore_after/)

## macOS & Linux

### インストール

- `git`が使えるか確認してください

```sh
# install brew (if need)
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# install chezmoi and apply dotfiles
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply "misumisumi/nixos-desktop-config"
```

### パッケージマネージャ

`mise`と`homebrew`を使った宣言的なパッケージインストールをサポートしています。
また、ディストリビューション標準のパッケージマネージャも使用できます。
詳しくは[.chezmoidata/users/sumi.toml](.chezmoidata/users/sumi.toml)をご覧ください。

|     pkg manager      |             admin              |
| :------------------: | :----------------------------: |
|         mise         |               no               |
|       homebrew       | no (required for installation) |
| apt, pacman, yum ... |              yes               |

### build requirements (Ubuntu)

- `build-essential`
- `nasm` # for ffmpeg
- `ncurses-dev bison` # for tmux
- [ruby wiki#suggested-build-environment](https://github.com/rbenv/ruby-build/wiki#suggested-build-environment)
