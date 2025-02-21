# Changelog

## [4.0.1](https://github.com/misumisumi/nixos-desktop-config/compare/v4.0.0...v4.0.1) (2025-02-21)


### Bug Fixes

* **nvim:** support mason-lock ([633dab1](https://github.com/misumisumi/nixos-desktop-config/commit/633dab1c1087e0bfb5f2e91fec0392fca1325eb4))
* **qtile:** add VerticalTile layout ([800b1c6](https://github.com/misumisumi/nixos-desktop-config/commit/800b1c661023b45282ff13727ff95ddf24fb341e))
* **zinit:** optimizing plug-in loads ([0d4f316](https://github.com/misumisumi/nixos-desktop-config/commit/0d4f316c398fd073b1f37a0208affe04daa4374f))

## [4.0.0](https://github.com/misumisumi/nixos-desktop-config/compare/v3.1.3...v4.0.0) (2025-02-16)


### ⚠ BREAKING CHANGES

* **chezmoi:** support to manage dotfiles by chezmoi

### Features

* **chezmoi:** add README ([76e0124](https://github.com/misumisumi/nixos-desktop-config/commit/76e0124ea53b6fd743b056c6009c5a987038575a))
* **chezmoi:** support chocolatey package ([b3709f1](https://github.com/misumisumi/nixos-desktop-config/commit/b3709f132f5ed41ccdfe038681720c00ba784e62))
* **chezmoi:** support decrypt sops file ([30d0409](https://github.com/misumisumi/nixos-desktop-config/commit/30d0409fa9d510782f0fdaa2250ba760e01f4171))
* **gnome-keyring:** support gnome-keyring ([b9d4f37](https://github.com/misumisumi/nixos-desktop-config/commit/b9d4f37cdf268fc9206dc4b3ef2f2c8ac524f7a2))
* **gpg:** support yubikey ([e607130](https://github.com/misumisumi/nixos-desktop-config/commit/e607130e1f88e1b9eafd704c683058f460b23fbf))
* **virtualsmartcard:** support remote smartcard reader ([de8303d](https://github.com/misumisumi/nixos-desktop-config/commit/de8303d802eed69186c5caf01e479f684be72129))


### Bug Fixes

* **aichat:** fix completion url ([bbf3412](https://github.com/misumisumi/nixos-desktop-config/commit/bbf3412eea5a2eb5130dba4331c05320a12740d6))
* **asusd:** follow up to upstream changes ([fcbbd40](https://github.com/misumisumi/nixos-desktop-config/commit/fcbbd4008afbc995aa1248e0f768eebb6a5fe5da))
* **bash:** fix config ([90943c0](https://github.com/misumisumi/nixos-desktop-config/commit/90943c078732c2e633db88d6dce529726b61dc05))
* **bash:** fix historyControl ([e304865](https://github.com/misumisumi/nixos-desktop-config/commit/e3048654e3f6125ba8d2e0081ca3055c4eb4ab54))
* **chezmoi:** add "_admin_" as prefix to script ([6913a51](https://github.com/misumisumi/nixos-desktop-config/commit/6913a5187a9ef7f5e8712c425ec3ed86ceb272ca))
* **chezmoi:** add install pkgs and generate ssh key script ([2d9b3a6](https://github.com/misumisumi/nixos-desktop-config/commit/2d9b3a64edb733e60a74c4a22bcc8a688d813614))
* **chezmoi:** add reactivating storage drive script ([d0d6699](https://github.com/misumisumi/nixos-desktop-config/commit/d0d6699137d2affee5d5adcbaf9ba58eeb198e93))
* **chezmoi:** deepening integration between nix and chezmoi ([4efe56b](https://github.com/misumisumi/nixos-desktop-config/commit/4efe56b95ec28fa4096ef89284b9d715cd350219))
* **chezmoi:** fix externals and add tmux config ([66a5f6e](https://github.com/misumisumi/nixos-desktop-config/commit/66a5f6e00ca78f2ef09bddc5c51c2aac31f68c04))
* **chezmoi:** fix script logic ([387a41b](https://github.com/misumisumi/nixos-desktop-config/commit/387a41b68c6ae3430bb006d71104c8b4990ab726))
* **chezmoi:** manage some app settings with .chezmoidata ([8ef3641](https://github.com/misumisumi/nixos-desktop-config/commit/8ef3641c58b8dfc2d09c77380ea3b7dcd2a451ba))
* **chezmoi:** missing config ([493fff8](https://github.com/misumisumi/nixos-desktop-config/commit/493fff8ec6344f834c60c8dafc3b3eb1d40a47c2))
* **chezmoi:** replace mise from asdf ([dab0abc](https://github.com/misumisumi/nixos-desktop-config/commit/dab0abc0c83cbb1718cbc9d9d41f168d917b033e))
* **chezmoi:** some fix ([acf2668](https://github.com/misumisumi/nixos-desktop-config/commit/acf2668715273c32aa1edfa9fc024b655b9c7862))
* **chezmoi:** some fix ([786c0f7](https://github.com/misumisumi/nixos-desktop-config/commit/786c0f70f8285592912761dc05ab0f7d7446478d))
* **chezmoi:** support to set each host machine and each user ([c6dbbc9](https://github.com/misumisumi/nixos-desktop-config/commit/c6dbbc9c85c1cd64666270d697beeccb6ca3a1e0))
* enable amd_pstate ([4e226bb](https://github.com/misumisumi/nixos-desktop-config/commit/4e226bbc9a4020055a03eff0836ce370bd98a3c2))
* fix keymap for dunst ([824d2bc](https://github.com/misumisumi/nixos-desktop-config/commit/824d2bc4e7520a54713612eda70107201c15af82))
* fix workspace config ([12e65fd](https://github.com/misumisumi/nixos-desktop-config/commit/12e65fd57799236d8335bd230e61a33d50fba5b2))
* fix zotero settings and sops encryption ([ed73ac8](https://github.com/misumisumi/nixos-desktop-config/commit/ed73ac8e45a77d91e77191440c56fc4a3cd6ef22))
* **fonts:** fix and enable fontconfig on home-manager ([68203e8](https://github.com/misumisumi/nixos-desktop-config/commit/68203e85b6c8ec04150e580ec74a2b22719af50c))
* **git:** need format ([fc125a3](https://github.com/misumisumi/nixos-desktop-config/commit/fc125a3c6a48ef94573cc7912fdd068049e1e7b3))
* **incus:** add sshfs ([22e9071](https://github.com/misumisumi/nixos-desktop-config/commit/22e90717388017b1ba821e4d1fbdb2237a3f7bbe))
* **moralerspace:** moralerspace was included in nixpkgs ([71c00ac](https://github.com/misumisumi/nixos-desktop-config/commit/71c00ac3ef8d1ae7e698925adeea958519423221))
* **moralerspace:** update version of moralerspace ([1a308be](https://github.com/misumisumi/nixos-desktop-config/commit/1a308beaa3a4cce7cc5e4b41c75ee7367801837c))
* **mpv:** enable hardware encoder if can use it ([88fc89c](https://github.com/misumisumi/nixos-desktop-config/commit/88fc89c3c4f5b06cb55fbcb7242308f9d9451123))
* **nix:** nur.default is deprecated ([6339721](https://github.com/misumisumi/nixos-desktop-config/commit/6339721669e35c243e7445d65182b0b37e87b71c))
* patch to moralerspace ([a4cea3f](https://github.com/misumisumi/nixos-desktop-config/commit/a4cea3f39882e0d3142ef822942615b30e86db14))
* **patches:** fix moralerspace-nerd-fonts-alt ([64643c4](https://github.com/misumisumi/nixos-desktop-config/commit/64643c4f12b0ae2be89d83fa5e0cfc06a52c86d3))
* **presets:** fix configs include each presets ([b478439](https://github.com/misumisumi/nixos-desktop-config/commit/b478439d369cabed688d8d46fb415b024544c229))
* **pulseaudio:** replace to services.pulseaudio from hardware.* ([815b2b0](https://github.com/misumisumi/nixos-desktop-config/commit/815b2b0c0f425b3c4f4719c4c77a64e1fad64907))
* **qtile:** add playerctl option ([a2b9ef6](https://github.com/misumisumi/nixos-desktop-config/commit/a2b9ef6530545a55ec3e6fa150e9c294204eccc5))
* **qtile:** fix config ([516cc5e](https://github.com/misumisumi/nixos-desktop-config/commit/516cc5e3b249fb5ba0f8d8af1003dd9743780417))
* **sops-nix:** donot use pgp when activate system ([698544e](https://github.com/misumisumi/nixos-desktop-config/commit/698544ec6052627b24a3ef96936322f28a516726))
* **sops:** fix sops directory ([c7fdcd4](https://github.com/misumisumi/nixos-desktop-config/commit/c7fdcd4251a87eb9cb299bb17213262c8a61d75b))
* **stacia:** add yubikey and fix gpu config ([3cd29d5](https://github.com/misumisumi/nixos-desktop-config/commit/3cd29d5a1f88784851cb5cd8f4e6f3bcd63db2f1))
* **starship:** fix reading file path ([c6b8ab0](https://github.com/misumisumi/nixos-desktop-config/commit/c6b8ab0307a3d595484143cf3611dd655ca05cd3))
* **starship:** replace to nerdfont for ssh_symbol ([2fbe726](https://github.com/misumisumi/nixos-desktop-config/commit/2fbe7267316b5e50d26404467d2bcfffac25a1da))
* **system:** add utils for disk monitor ([8709ab3](https://github.com/misumisumi/nixos-desktop-config/commit/8709ab38d92899522cec312db00f68d1f7e8964b))
* **texlive:** add filter-mermaid ([cdc657e](https://github.com/misumisumi/nixos-desktop-config/commit/cdc657e82c4a2a65c93e1542f7ffd38e4b06e5bd))
* **tmux:** fix missing dracura plugin config ([6d3a994](https://github.com/misumisumi/nixos-desktop-config/commit/6d3a9946ee31e124015b7a1a71747db593f6a40d))
* **tmux:** fix prefix ([85508ec](https://github.com/misumisumi/nixos-desktop-config/commit/85508ec64f416f4b0706495dc334f954f767bcd7))
* **tmux:** fix prefix and color setting ([23ccb92](https://github.com/misumisumi/nixos-desktop-config/commit/23ccb920216d09d30e35d16d528404745cb6f871))
* **tmux:** fix prefix for tilish ([57fb241](https://github.com/misumisumi/nixos-desktop-config/commit/57fb241d406c65ff5ed3b0c326ec4e2a3337ef4b))
* **tmux:** remove keymap for kill-* and add keymap for swap ([8936c5b](https://github.com/misumisumi/nixos-desktop-config/commit/8936c5b38fd94a8e8d172be1700b11546c25dda2))
* **tmux:** remove prefix2 ([c4f1863](https://github.com/misumisumi/nixos-desktop-config/commit/c4f186324effe780a99f14a730f62a4b66a941ac))
* **vfio:** remove hooks option ([7410078](https://github.com/misumisumi/nixos-desktop-config/commit/741007863a2b0e9b0f1be898aeb1d0a464fd4e66))
* **vivaldi:** remove `save to pocket` ([410f3fe](https://github.com/misumisumi/nixos-desktop-config/commit/410f3fe09938a939832020cd50738879c9420bdb))
* **wezterm:** fix keymap ([169cd6f](https://github.com/misumisumi/nixos-desktop-config/commit/169cd6f5600950e8a60dce3faad2df31c8b469de))
* **yazi:** add extra dependent package ([96f2800](https://github.com/misumisumi/nixos-desktop-config/commit/96f2800ac644b522dc9c8a6e8b0f153c8be19b7c))
* **zathura:** adding syntax settings ([bb9f81f](https://github.com/misumisumi/nixos-desktop-config/commit/bb9f81f5cb9624971cc5460ea96ed939184fb9e3))
* **zathura:** replace to rbga for highlight ([ca17010](https://github.com/misumisumi/nixos-desktop-config/commit/ca170104aa714ebef86c45986297e4bd1b8b8cef))
* **zinit:** add option for no_alias ([d700118](https://github.com/misumisumi/nixos-desktop-config/commit/d700118ef6664ad48128cf96a1ff38be9f1692be))


### Code Refactoring

* **chezmoi:** support to manage dotfiles by chezmoi ([de9a58f](https://github.com/misumisumi/nixos-desktop-config/commit/de9a58f5b2279b5c769cc4753fe9ab7a29a93da3))

## [3.1.3](https://github.com/misumisumi/nixos-desktop-config/compare/v3.1.2...v3.1.3) (2024-12-15)


### Bug Fixes

* **flake:** fix attr name of nur ([17f8f44](https://github.com/misumisumi/nixos-desktop-config/commit/17f8f44f351574f66a05b01a4da9fa38cc6c16ba))

## [3.1.2](https://github.com/misumisumi/nixos-desktop-config/compare/v3.1.1...v3.1.2) (2024-12-13)


### Bug Fixes

* **qtile:** respect aspect ratio for PinP ([9036489](https://github.com/misumisumi/nixos-desktop-config/commit/9036489aaf6261505fb82acb2b50e443b0058308))

## [3.1.1](https://github.com/misumisumi/nixos-desktop-config/compare/v3.1.0...v3.1.1) (2024-12-09)


### Bug Fixes

* fix deprecated config ([03ee793](https://github.com/misumisumi/nixos-desktop-config/commit/03ee793f98967ad94eb99edd9273a5e79a05495a))
* **flake:** fix flake inputs ([4552f86](https://github.com/misumisumi/nixos-desktop-config/commit/4552f864d84c31431ae315f80acf6742a9e5ac4f))

## [3.1.0](https://github.com/misumisumi/nixos-desktop-config/compare/v3.0.1...v3.1.0) (2024-12-02)


### Features

* **nix:** add blender-bin (GPU support) and fix cache settings ([d7d6693](https://github.com/misumisumi/nixos-desktop-config/commit/d7d66930cc2852ae48562ee74db9eefe6ec18b7d))
* **virtualisation:** add virtiofsd for supporting virtiofs ([fb456ba](https://github.com/misumisumi/nixos-desktop-config/commit/fb456ba4da8d393974e19ffdfb5b0e751dbbe205))


### Bug Fixes

* **fcitx5-skk:** fix missing json format ([92931e6](https://github.com/misumisumi/nixos-desktop-config/commit/92931e66ec21061abb45f42e545bee7b652bdf24))
* fix tool configs ([cc2c821](https://github.com/misumisumi/nixos-desktop-config/commit/cc2c8214688cf1b07f775d9b2d3ecc8ca654321b))
* **nix:** remove nix-community cache ([c59757f](https://github.com/misumisumi/nixos-desktop-config/commit/c59757f8b5186a08c8e9a11ac98ad19eab13b6cc))
* **qtile:** add border to Max layout ([3769f62](https://github.com/misumisumi/nixos-desktop-config/commit/3769f62c65fa9b57c9d7297c79b47c8e6980cd84))
* **qtile:** add color for `mod4` of chord and fix keymap ([66bbc9c](https://github.com/misumisumi/nixos-desktop-config/commit/66bbc9ca8b43acfaf50eb341b49abe1f2e8cb776))
* **qtile:** support replacing mod key ([dfad961](https://github.com/misumisumi/nixos-desktop-config/commit/dfad9616b9cc19816b046d0306962fdd18b42eb1))
* **rofi:** fix window width ([4c84f8a](https://github.com/misumisumi/nixos-desktop-config/commit/4c84f8ae5e35b3a87276d40230b0bab9cffacb0c))
* **steam:** add proton-ge-rtsp ([f78d99c](https://github.com/misumisumi/nixos-desktop-config/commit/f78d99c8b3b49456af6111b6a93ea1d3c085f1c3))
* **tokyonight:** fix typo ([7aeef7d](https://github.com/misumisumi/nixos-desktop-config/commit/7aeef7d583b7ce7f0c88b9fce1b1b78f602ce749))
* **yazi:** add disableInitExecTls=true ([9c26f50](https://github.com/misumisumi/nixos-desktop-config/commit/9c26f5035d5b727acac07db0bcec2b3752cf7aa9))
* **yq:** replace to yq from yq-go ([cbce51d](https://github.com/misumisumi/nixos-desktop-config/commit/cbce51d391989880120339246e8e1c21db4915aa))
* **zsh:** add shellAlias ([db42063](https://github.com/misumisumi/nixos-desktop-config/commit/db420638f86e0f4e51526f4f08fc8dce11856916))
* **zsh:** fix zshenv ([629257d](https://github.com/misumisumi/nixos-desktop-config/commit/629257d6411b3ac1b042ca108b17ad5fbefc2e52))

## [3.0.1](https://github.com/misumisumi/nixos-desktop-config/compare/v3.0.0...v3.0.1) (2024-10-28)


### Bug Fixes

* **machines:** fix opencl driver for AMD ([01e42fa](https://github.com/misumisumi/nixos-desktop-config/commit/01e42fad9ce3e0a8f6c8f98950799564f1c6f47e))
* **obs-ndi:** add patch for deprecating Qt function ([6232667](https://github.com/misumisumi/nixos-desktop-config/commit/6232667f75f281ff2cfc337269db9db2315d60f7))
* **qtile:** fix for kdeconnect ([b64242c](https://github.com/misumisumi/nixos-desktop-config/commit/b64242c4849f07ffdb3436f2529bf476f3d8e77d))
* **soleus:** fix rootfs disk ([bb38609](https://github.com/misumisumi/nixos-desktop-config/commit/bb38609e550cf55b8977414c232e312fb6d52332))

## [3.0.0](https://github.com/misumisumi/nixos-desktop-config/compare/v2.2.6...v3.0.0) (2024-10-11)


### ⚠ BREAKING CHANGES

* refactor nixos and home-manager config!

### Features

* add color-theme for system ([e684714](https://github.com/misumisumi/nixos-desktop-config/commit/e68471459d96098988a6fb6ddcbef067e75bb03a))
* **color-theme:** support selecting sub color sheme ([4b19079](https://github.com/misumisumi/nixos-desktop-config/commit/4b19079865dda748909add25ba81eb0be2cc8392))
* **hm/qtile:** add qtile module ([8070604](https://github.com/misumisumi/nixos-desktop-config/commit/8070604a127ade67a76b7f53765bd5e737de1929))
* **hm/qtile:** add qtile module ([cd5af49](https://github.com/misumisumi/nixos-desktop-config/commit/cd5af491ad4fe84d22685ad5f87e201a5b46a165))
* **nord:** add nord color theme ([12ad445](https://github.com/misumisumi/nixos-desktop-config/commit/12ad445adf1aaca42310dbde25d1418e588ef8ed))
* **steam:** add steam ([84174a4](https://github.com/misumisumi/nixos-desktop-config/commit/84174a44b60e56d5206816bf8609ed102e3df945))
* **theme:** add nord and tokyo-night theme ([bf999d7](https://github.com/misumisumi/nixos-desktop-config/commit/bf999d7db278ddfb4716507b571cf9f534f29e85))
* **vimium:** add theme css ([ee30e57](https://github.com/misumisumi/nixos-desktop-config/commit/ee30e57db02ab082ffc5d6fe134cc6d16ce899ea))


### Bug Fixes

* **aichat:** fix aichat roles ([e38ea57](https://github.com/misumisumi/nixos-desktop-config/commit/e38ea575548d801dd46f12b6751bc5e23f00f207))
* bug and sytle fix ([e7656e6](https://github.com/misumisumi/nixos-desktop-config/commit/e7656e64fcfbd93e807cd66cda8e5a88f928c3c2))
* bug fix ([0d35c6a](https://github.com/misumisumi/nixos-desktop-config/commit/0d35c6a0ca76f4d6df91597c65e88b3ae2435539))
* **color-theme:** fix some config ([3d033d0](https://github.com/misumisumi/nixos-desktop-config/commit/3d033d019751b3808a5ec384aebfa3410f206882))
* **color-theme:** put theme for rofi under XDGConfig ([dc1a6e4](https://github.com/misumisumi/nixos-desktop-config/commit/dc1a6e409f75fa475ce78dfeb7ee5c67b65b82aa))
* **color-theme:** some fix ([1814bf2](https://github.com/misumisumi/nixos-desktop-config/commit/1814bf2b92de08fd7091f36bea76716480fce4a2))
* **color-theme:** some fix ([e0002ed](https://github.com/misumisumi/nixos-desktop-config/commit/e0002edaf515d1a61eac4c6a18233dbc8af64ad6))
* **desktop:** fix dunst config and add obsidian ([8253e15](https://github.com/misumisumi/nixos-desktop-config/commit/8253e156cd5ce5e8d6acc34ca114b56547741a54))
* **dunst:** fix keybind and icon size ([4846b05](https://github.com/misumisumi/nixos-desktop-config/commit/4846b057298a299b2f3c09eb8c2d96fe2ea663f4))
* **editorconfig:** add config for terraform ([301cd1a](https://github.com/misumisumi/nixos-desktop-config/commit/301cd1a7fd3ddaac1333a5ca89fbaa1191404f28))
* fix backlight control ([57b3a83](https://github.com/misumisumi/nixos-desktop-config/commit/57b3a834f7910114d6204aa83da4e53e0471c044))
* fix keymap ([c492cce](https://github.com/misumisumi/nixos-desktop-config/commit/c492cce216e808f03f7d8fddce3f9881405562d9))
* fix screenshot settings ([03f61e1](https://github.com/misumisumi/nixos-desktop-config/commit/03f61e1bbcbef1a871706a61f38d5e324a5a54bb))
* fix submodule and remove zotero-extensions ([97e735b](https://github.com/misumisumi/nixos-desktop-config/commit/97e735b4198e3178a4aadb3a19aab43c40112033))
* **fonts:** remove ignore comment ([9654abf](https://github.com/misumisumi/nixos-desktop-config/commit/9654abffbcce903a478044f613986dd781e7ca89))
* **hm-module:** remove user and host-specific imports ([8d3bff8](https://github.com/misumisumi/nixos-desktop-config/commit/8d3bff846b4810a7f398bca9add5711d4bc637ea))
* **locale:** enable geoclue2 ([e09c660](https://github.com/misumisumi/nixos-desktop-config/commit/e09c6608eabc2a9f91d886e8894cfd83b201727f))
* **machines:** add `hardware.nvidia.open=false;` ([de7249b](https://github.com/misumisumi/nixos-desktop-config/commit/de7249be1d7ef6c41987d17b54972d346f2be6c9))
* **modules:** fix adding module ([8070604](https://github.com/misumisumi/nixos-desktop-config/commit/8070604a127ade67a76b7f53765bd5e737de1929))
* **modules:** fix adding module ([75636a4](https://github.com/misumisumi/nixos-desktop-config/commit/75636a440465d7a575862b4cf7b6b0ad243fd555))
* **modules:** remove scheme 'none' ([d3fe79e](https://github.com/misumisumi/nixos-desktop-config/commit/d3fe79ef818cdc1389526e18af99a0c7453cdfa9))
* **mother:** fix mother config ([c75778d](https://github.com/misumisumi/nixos-desktop-config/commit/c75778d83dbd375edc1a78a915e8d489760d07ff))
* move `trash-cli` to core/programs ([34f0f9f](https://github.com/misumisumi/nixos-desktop-config/commit/34f0f9f6e042985b63ecf91582cd2d49a8426a8a))
* **picom:** fix picom config ([1344077](https://github.com/misumisumi/nixos-desktop-config/commit/13440776a4960cdbe642e640f123eff01380924e))
* **picom:** fix picom config ([a1b2e17](https://github.com/misumisumi/nixos-desktop-config/commit/a1b2e17f9b9c2f128c01b2dd5ecdaad3ffd3b013))
* **podman:** fix nvidia-container config ([d292800](https://github.com/misumisumi/nixos-desktop-config/commit/d29280045e1a51fe55a9e6f65c473f187c3418f6))
* **qtile:** enphance dynamic monitor attach ([c13b7ba](https://github.com/misumisumi/nixos-desktop-config/commit/c13b7bac4cf1d4962cd3f6ab58c3ccdb427baff9))
* **qtile:** fix bug of wallpaper and window rule ([34e70c4](https://github.com/misumisumi/nixos-desktop-config/commit/34e70c4b634cf8ca629e8620a4ac613232f8972e))
* **qtile:** fix config ([4d58f26](https://github.com/misumisumi/nixos-desktop-config/commit/4d58f26eb37833eda71c6bc5c4394df3c279f2a6))
* **qtile:** fix config ([7e4c12a](https://github.com/misumisumi/nixos-desktop-config/commit/7e4c12a69aba3e7f5023ae3e1678232966d4668f))
* **qtile:** fix pentablet config ([1cc7438](https://github.com/misumisumi/nixos-desktop-config/commit/1cc74383a889551e2b8fa92c278e69e2767ad71d))
* **qtile:** fix some bug ([1d9bd99](https://github.com/misumisumi/nixos-desktop-config/commit/1d9bd99b26299bbcdbb338537e464b895cf3875e))
* **qtile:** modifying dynamic display settings ([c4e3df9](https://github.com/misumisumi/nixos-desktop-config/commit/c4e3df9a040f775832071f932649cf339718c2f3))
* **qtile:** redule ws and fix color conf ([6cda66b](https://github.com/misumisumi/nixos-desktop-config/commit/6cda66b87d6be330b5b9e98d873eec9386d83661))
* **README:** fix README ([1faa4e1](https://github.com/misumisumi/nixos-desktop-config/commit/1faa4e136b4f68c9a9393acdadaa7a2e34b5b9d2))
* rename pkg.gnome.* to pkg.* ([2833384](https://github.com/misumisumi/nixos-desktop-config/commit/2833384fda39a607eae21630e4e01a4a9c2bc5d5))
* **rofi:** add rofi-emoji ([75099d8](https://github.com/misumisumi/nixos-desktop-config/commit/75099d8c5628e65da2c385ca0e27b4c7dbd3dbc5))
* **soleus:** fix soleus config ([f08061a](https://github.com/misumisumi/nixos-desktop-config/commit/f08061a4ba27d61e53c004c031c4a34fa375da65))
* **sops:** fix age key dir ([59ddb5c](https://github.com/misumisumi/nixos-desktop-config/commit/59ddb5c24b9cec6611ad59b6794fe6cb9def11ca))
* **sops:** fix wifi password ([89a6a5a](https://github.com/misumisumi/nixos-desktop-config/commit/89a6a5a7c16df81fd37bf6fb1027c9d87136ce4e))
* **sops:** move sops setting to per users ([26e1f3b](https://github.com/misumisumi/nixos-desktop-config/commit/26e1f3b28a1f6189f199af095710d859b2b9c741))
* **sops:** move sops setting to per users ([a2b0614](https://github.com/misumisumi/nixos-desktop-config/commit/a2b0614bee649f9f94e9555dc8345256a38fa117))
* **sops:** update keys ([459d653](https://github.com/misumisumi/nixos-desktop-config/commit/459d653530f6243f562e101e2f02dcea7ee792ba))
* **spicitify:** support selecting color theme ([abba01b](https://github.com/misumisumi/nixos-desktop-config/commit/abba01b7cfe86282c58046c20a9203e34b8be113))
* **texlive:** remove some package ([3c7b47a](https://github.com/misumisumi/nixos-desktop-config/commit/3c7b47af588978d04030f025a147d577e2030f35))
* **texlive:** remove some package ([5eb54a3](https://github.com/misumisumi/nixos-desktop-config/commit/5eb54a3ac1e1579f662c25ab361ed58bfdafa841))
* **theme:** fix config ([60decdb](https://github.com/misumisumi/nixos-desktop-config/commit/60decdb365152f3092f53e42f28a036566b6b675))
* var of wm must set `none` or WM name ([77c99bf](https://github.com/misumisumi/nixos-desktop-config/commit/77c99bff2d8dbb235923a0fb162167ad749ef8af))
* **wallpaper:** renew wallpaper ([ced9464](https://github.com/misumisumi/nixos-desktop-config/commit/ced94640829c45447a02a1c4b5652ccadf6697bc))
* **wezterm:** add response time in tab bar ([1330eaf](https://github.com/misumisumi/nixos-desktop-config/commit/1330eaffe02fec33a3253e246d3f4741ee11eea5))
* **wezterm:** add response time in tab bar ([910abcb](https://github.com/misumisumi/nixos-desktop-config/commit/910abcb73e83733a380666c083ed6d539f416ee7))
* **wezterm:** incompatible with nvidia's latest drivers ([8d48c7c](https://github.com/misumisumi/nixos-desktop-config/commit/8d48c7cf642e2160edcb56ccde2c516904b3b2d5))
* **wm:** some fix ([567e8e9](https://github.com/misumisumi/nixos-desktop-config/commit/567e8e9cbd791c8a238eb8c32776abb3014c3920))
* **zephyrus:** a setting `hardware.nvidia.open` is required ([4f3b780](https://github.com/misumisumi/nixos-desktop-config/commit/4f3b780a5b84a9403fe04ffc79b95d8d6c13ddb6))
* **zephyrus:** add prime run ([e51a909](https://github.com/misumisumi/nixos-desktop-config/commit/e51a909bfb9f4edfbfd64b7ff27ff499509478ae))
* **zephyrus:** fix deprecated conf ([98cecae](https://github.com/misumisumi/nixos-desktop-config/commit/98cecaed3369fb3a04a8c804d97f99734597f7d8))
* **zephyrus:** fix gpu config ([10424cd](https://github.com/misumisumi/nixos-desktop-config/commit/10424cd0d847b4afec2e1aa646e88723218df1a1))
* **zephyrus:** recover nixos-hardware ([f9233fd](https://github.com/misumisumi/nixos-desktop-config/commit/f9233fdcc4a4da99751d6aec179c7c0799210f1a))


### Code Refactoring

* refactor nixos and home-manager config! ([cd87488](https://github.com/misumisumi/nixos-desktop-config/commit/cd874884a99da824aeacd893d0e787d25ae497e7))

## [2.2.6](https://github.com/misumisumi/nixos-desktop-config/compare/v2.2.5...v2.2.6) (2024-08-30)


### Bug Fixes

* **neovim:** move nixpkgs-fmt to nixfmt-rfc-style ([fd7b0b1](https://github.com/misumisumi/nixos-desktop-config/commit/fd7b0b151146e7eb8e4f4b88f91fc72791ff10d6))
* **nix:** fix cache config ([3638e51](https://github.com/misumisumi/nixos-desktop-config/commit/3638e512e6c1223e11474687e160ae1287dda11a))
* **spicetify:** remove patch ([d9e7100](https://github.com/misumisumi/nixos-desktop-config/commit/d9e7100746de3f2478de8f08341b03acba0e9acb))
* **stacia:** fix network config ([495adc5](https://github.com/misumisumi/nixos-desktop-config/commit/495adc5f27a4b1e5a43ee9673d3a850c18cc27b2))
* **theme:** remove deprecated config ([ea5749d](https://github.com/misumisumi/nixos-desktop-config/commit/ea5749d06f7bb0504d4ae984159bc47a4fea2e1e))
* **vivaldi:** fix extension ([f1e0a57](https://github.com/misumisumi/nixos-desktop-config/commit/f1e0a5766b5aba679c27714cff24a746fa57c834))

## [2.2.5](https://github.com/misumisumi/nixos-desktop-config/compare/v2.2.4...v2.2.5) (2024-08-09)


### Bug Fixes

* **user-env:** enable nix-gc in user env ([b4c0982](https://github.com/misumisumi/nixos-desktop-config/commit/b4c09822ba66acce328bad8feacc6f0c37f9d53a))
* **vivaldi:** add extension named i don't care about cookies ([9ddf1c9](https://github.com/misumisumi/nixos-desktop-config/commit/9ddf1c92a64a29934bc8770275b1151e4982c449))

## [2.2.4](https://github.com/misumisumi/nixos-desktop-config/compare/v2.2.3...v2.2.4) (2024-08-04)


### Bug Fixes

* **cinnamon-pkgs:** move pkgs.cinnamon.&lt;pkg-name&gt; to pkgs.<pkg-name> ([2bc46ec](https://github.com/misumisumi/nixos-desktop-config/commit/2bc46ec22aaba891063a229b6b2bc618500f2555))

## [2.2.3](https://github.com/misumisumi/nixos-desktop-config/compare/v2.2.2...v2.2.3) (2024-07-27)


### Bug Fixes

* **texlive:** add some package ([8f95563](https://github.com/misumisumi/nixos-desktop-config/commit/8f9556356cde2f2d8188c8d050fc576bf2393aa9))

## [2.2.2](https://github.com/misumisumi/nixos-desktop-config/compare/v2.2.1...v2.2.2) (2024-07-21)


### Bug Fixes

* **qtile:** fix missing icon ([175ec31](https://github.com/misumisumi/nixos-desktop-config/commit/175ec3108067e4c3fa49ee5b040b42ffd4d90ee4))

## [2.2.1](https://github.com/misumisumi/nixos-desktop-config/compare/v2.2.0...v2.2.1) (2024-07-21)


### Bug Fixes

* **sound:** remove sound.enable option ([ecce3fa](https://github.com/misumisumi/nixos-desktop-config/commit/ecce3fade990fab68024fb50b92825c0a7bf4d42))

## [2.2.0](https://github.com/misumisumi/nixos-desktop-config/compare/v2.1.5...v2.2.0) (2024-07-19)


### Features

* **zotero:** add zotero home-manager module ([633834b](https://github.com/misumisumi/nixos-desktop-config/commit/633834bf25834374112dd203f6c90abae976fc18))


### Bug Fixes

* **firefox:** automatically enable extensions ([eea3eb8](https://github.com/misumisumi/nixos-desktop-config/commit/eea3eb84c23e80f661c47ccceff5baa56574d1f6))

## [2.1.5](https://github.com/misumisumi/nixos-desktop-config/compare/v2.1.4...v2.1.5) (2024-07-17)


### Bug Fixes

* **full/pkgs:** add sops ([3d470bf](https://github.com/misumisumi/nixos-desktop-config/commit/3d470bff9613ad7b4ffbb6e1ea189c70aed317bc))
* **neovim:** fix obsidian.nvim ([4d6d835](https://github.com/misumisumi/nixos-desktop-config/commit/4d6d8357bae161f06b44b7605c6cfaa40a97edd2))

## [2.1.4](https://github.com/misumisumi/nixos-desktop-config/compare/v2.1.3...v2.1.4) (2024-07-06)


### Bug Fixes

* fix pkg name ([f402386](https://github.com/misumisumi/nixos-desktop-config/commit/f4023860d6299bf54d06c34fac6c94ccabfb9fd7))

## [2.1.3](https://github.com/misumisumi/nixos-desktop-config/compare/v2.1.2...v2.1.3) (2024-07-04)


### Bug Fixes

* **aichat:** add completion and role ([837aac1](https://github.com/misumisumi/nixos-desktop-config/commit/837aac1855642c446bf44830d3da29539e7a71a5))

## [2.1.2](https://github.com/misumisumi/nixos-desktop-config/compare/v2.1.1...v2.1.2) (2024-07-04)


### Bug Fixes

* **workflow:** dealing with secondary rate limits ([5018380](https://github.com/misumisumi/nixos-desktop-config/commit/5018380a6698b327c62a278d56ee80e983d4afe5))

## [2.1.1](https://github.com/misumisumi/nixos-desktop-config/compare/v2.1.0...v2.1.1) (2024-07-03)


### Bug Fixes

* **aichat:** add prompt ([7aa421c](https://github.com/misumisumi/nixos-desktop-config/commit/7aa421c7fe3c3bf2c0aa6987998a2cfe30a324fe))
* change repo of spicetify-nix ([ff8922a](https://github.com/misumisumi/nixos-desktop-config/commit/ff8922a035e3d45c7f248b4bf238e4856118cd61))
* encrypt file type ([7d8d469](https://github.com/misumisumi/nixos-desktop-config/commit/7d8d46957a2c0881ff022d71b803dc29afea6ddc))
* encrypt file type ([28bcd69](https://github.com/misumisumi/nixos-desktop-config/commit/28bcd699214a295fb443416f1a471c8313eea636))
* fix deprecated define ([a605ad9](https://github.com/misumisumi/nixos-desktop-config/commit/a605ad9f30ea9a786fd9fe33e06a3a149799f4bc))
* **nvidia:** cannot show display from dvi with latest driver ([c5d8c10](https://github.com/misumisumi/nixos-desktop-config/commit/c5d8c104337341a2a0149c3b01f434535384c1d4))
* **spicetify:** add patch ([3213091](https://github.com/misumisumi/nixos-desktop-config/commit/3213091faa560a696cc8577238731c43e358c0c2))
* **zsh:** remove expand comp ([1e7ee1d](https://github.com/misumisumi/nixos-desktop-config/commit/1e7ee1df259ad8a2c5f42d3714282d05ad544c23))

## [2.1.0](https://github.com/misumisumi/nixos-desktop-config/compare/v2.0.2...v2.1.0) (2024-07-02)


### Features

* **aichat:** add aichat ([4df56fb](https://github.com/misumisumi/nixos-desktop-config/commit/4df56fb2c4c959669bdd53d2bbe1dd90f0416486))
* **neovim:** use mergeLazyLock cmd ([7b85616](https://github.com/misumisumi/nixos-desktop-config/commit/7b856163303c64a9ec506df6452793622cd54a7d))
* **obsidian:** add obsidian ([a4a9a2f](https://github.com/misumisumi/nixos-desktop-config/commit/a4a9a2fd872d95b149de36e5dea858bc1373d4fe))


### Bug Fixes

* bridgeConfig and fix xineramainfoorder ([252d5de](https://github.com/misumisumi/nixos-desktop-config/commit/252d5de038b504886d8934a685e9fe2fa2044935))
* desktop env ([066bf0b](https://github.com/misumisumi/nixos-desktop-config/commit/066bf0b450f008522adbd1426b4b646b73ddeefc))
* fix attr names ([26fab2c](https://github.com/misumisumi/nixos-desktop-config/commit/26fab2c802be7934f14738f54e3bd768039fc0bf))
* fix encrypt file ([1e8078e](https://github.com/misumisumi/nixos-desktop-config/commit/1e8078e6706dd3ad97301c4bf667bb1db4efea68))
* fix mother network conf ([956087f](https://github.com/misumisumi/nixos-desktop-config/commit/956087fade55f572011d2532d2a88b323e07ef05))
* **latexmk:** fix latexmk config ([7acdbed](https://github.com/misumisumi/nixos-desktop-config/commit/7acdbed8de90369f792d0ed5f24d1a3ee921e163))
* migrate to noto ([62698af](https://github.com/misumisumi/nixos-desktop-config/commit/62698afff6972f383c8613a38ad77b5591855634))
* **qtile:** wallpaper ([1bd9ff3](https://github.com/misumisumi/nixos-desktop-config/commit/1bd9ff338201800aa96572b53e8bc27f02fe599a))
* **skk:** add dict ([3ff225f](https://github.com/misumisumi/nixos-desktop-config/commit/3ff225fa39fe1d5ddddc592d9d38ed3fc52b5689))
* some fix ([7e35327](https://github.com/misumisumi/nixos-desktop-config/commit/7e3532794581413fdbc287f5ac73ac4f9824244f))
* terminal font ([5b9229c](https://github.com/misumisumi/nixos-desktop-config/commit/5b9229cfc19fe3e49b218622794dfcfe12e75c8d))
* terminal font ([0da6529](https://github.com/misumisumi/nixos-desktop-config/commit/0da65292961496987cee5603df67d742f6f43762))
* **texlive:** add ieeetran ([34d841b](https://github.com/misumisumi/nixos-desktop-config/commit/34d841b057c1a9d1b3670b0d80283acd97307f60))
* **texlive:** add some package ([3cf44a1](https://github.com/misumisumi/nixos-desktop-config/commit/3cf44a1cf099ac795949d925b082dc41a34106fc))
* update and fix patch ([ec973b7](https://github.com/misumisumi/nixos-desktop-config/commit/ec973b7453625f1166f9dbbb3e969708b06a963d))
* **waydroid:** add desktop entry of weston ([f7fff74](https://github.com/misumisumi/nixos-desktop-config/commit/f7fff745579fe64954751867ec16c52a730e292b))
* **wezterm:** fix keymap ([fb28bc6](https://github.com/misumisumi/nixos-desktop-config/commit/fb28bc6e30706c2cfa126409a0128d68a86a42cc))

## [2.0.2](https://github.com/misumisumi/nixos-desktop-config/compare/v2.0.1...v2.0.2) (2024-05-19)


### Bug Fixes

* **qtile:** add xdg-desktop-portal setting ([71b30fe](https://github.com/misumisumi/nixos-desktop-config/commit/71b30fe4365f65ff10183572cb49409c0e2919e9))
* remove lxd ([d5f4d4f](https://github.com/misumisumi/nixos-desktop-config/commit/d5f4d4f380a986be8bddf5599dab5acd491ee2e8))
* **soleus:** fix path ([a483626](https://github.com/misumisumi/nixos-desktop-config/commit/a48362666862f1f0e4130948787f5076420260ee))
* **sops:** update keys ([a5a6c0d](https://github.com/misumisumi/nixos-desktop-config/commit/a5a6c0da03faa775f99a1a71ae35cb2d6f2a747a))
* **starship:** remove transient prompt ([e00e380](https://github.com/misumisumi/nixos-desktop-config/commit/e00e3800644a107ad340d1985a21ba0b689665e9))

## [2.0.1](https://github.com/misumisumi/nixos-desktop-config/compare/v2.0.0...v2.0.1) (2024-05-14)


### Bug Fixes

* **neovim:** update neovim input ([4bbbb58](https://github.com/misumisumi/nixos-desktop-config/commit/4bbbb5828cf41d3fc140c7753275354820d9192a))

## 2.0.0 (2024-05-12)


### ⚠ BREAKING CHANGES

* clean up
* include user-wide settings

### Features

* add some pkg and add cmd of disko ([dc5967c](https://github.com/misumisumi/nixos-desktop-config/commit/dc5967c01f922ed0e6f04c87437f02d1b1592609))
* add spicetify ([f2fd1f5](https://github.com/misumisumi/nixos-desktop-config/commit/f2fd1f5b732ed7e328decdaa7117409fb63bacda))
* clean up ([5f6b321](https://github.com/misumisumi/nixos-desktop-config/commit/5f6b3213787ecdee68200f0ad1de2fb705db2250))
* create default incus config ([3c1e1dd](https://github.com/misumisumi/nixos-desktop-config/commit/3c1e1dd594f86ec5feac6578af57b393ed88f0d5))
* enable nftable for incus ([581633e](https://github.com/misumisumi/nixos-desktop-config/commit/581633ef00e56997b4c8aaefd20c51b4daec3234))
* fix auto approve and support dependabot ([a39b120](https://github.com/misumisumi/nixos-desktop-config/commit/a39b1208ffc22f0ab9adef752b47b79fe87e9fe0))
* improbe xp-pen-driver support ([d1c9cbd](https://github.com/misumisumi/nixos-desktop-config/commit/d1c9cbde0c8aa34707c35578b352fde1ab32bbe6))
* reviewdog support ([e24edaa](https://github.com/misumisumi/nixos-desktop-config/commit/e24edaa3629d6695a0f60dfc98ea3a7d7b403016))
* support `disko` for recovery disk ([883363d](https://github.com/misumisumi/nixos-desktop-config/commit/883363dd2ef90dd053970c06143f02ede53ea671))
* support incus ([b80acb5](https://github.com/misumisumi/nixos-desktop-config/commit/b80acb5dd3ccaa516c333b2ed1e359e64b9a56cf))
* 複数のvlanに対応させたbridgeの作成 ([2b53f42](https://github.com/misumisumi/nixos-desktop-config/commit/2b53f4202853af3b2f9969c06cadf06ebc1bc36c))


### Bug Fixes

* **.nixd.json:** use nixpkgs-fmt ([76887de](https://github.com/misumisumi/nixos-desktop-config/commit/76887de54a916063c0f658bdd6506ad3445fe91b))
* allow root user login ([b86d0dc](https://github.com/misumisumi/nixos-desktop-config/commit/b86d0dca08e39ab93f67ccd415d1d72b2a4029ee))
* auto-approve workflow ([8ec2de5](https://github.com/misumisumi/nixos-desktop-config/commit/8ec2de5a21812c163203f87e00aa598cc902d5fe))
* background setting was exist in `xserver` ([2b6e9c7](https://github.com/misumisumi/nixos-desktop-config/commit/2b6e9c7775c273888ef4caf30adf3f692fcd2c51))
* boot usb setting ([c27e9c1](https://github.com/misumisumi/nixos-desktop-config/commit/c27e9c190e14d3c1311a5f0ce7bde884fa5d79a8))
* change option name ([0149040](https://github.com/misumisumi/nixos-desktop-config/commit/0149040f18e01f8e2a4c2bc1c6a550bc902264e8))
* depricate config ([2e3cd91](https://github.com/misumisumi/nixos-desktop-config/commit/2e3cd91359ece765fcecc35604f1f34f31ea84c7))
* fix conflicting ([23415ca](https://github.com/misumisumi/nixos-desktop-config/commit/23415cab6a5f824bc46169e18f484eae426872fa))
* fix module name ([c05f039](https://github.com/misumisumi/nixos-desktop-config/commit/c05f0391b37e292e15500898d809eb5a664a8d26))
* gnome ([c6dbf13](https://github.com/misumisumi/nixos-desktop-config/commit/c6dbf13579c801aad97c46f8ee0dfef7a51e8bdf))
* **libinputs:** fix option name ([fa8aabc](https://github.com/misumisumi/nixos-desktop-config/commit/fa8aabc8f9d8424302df5185c9b274e0f1786d86))
* **network:** fix vlan-tag network ([45b99e0](https://github.com/misumisumi/nixos-desktop-config/commit/45b99e0bd503171e4f248ebafbcf97c090e37f38))
* **nvidia-container-toolkit:** rename option to `hardware.nvidia-container-toolkit` ([da47090](https://github.com/misumisumi/nixos-desktop-config/commit/da4709096fcb95347a9ecbe6305cfed41effa83a))
* openfortivpn ([678a712](https://github.com/misumisumi/nixos-desktop-config/commit/678a7121c1b718b36601656ebaefce3f84155c95))
* remove hm dir ([d3cb2f5](https://github.com/misumisumi/nixos-desktop-config/commit/d3cb2f5fc08a6193dc57a5a6dbeb57afab457b2c))
* remove patch of incus ([6c9a5dd](https://github.com/misumisumi/nixos-desktop-config/commit/6c9a5dd4b7b497e130231c7c79631e1632bd3072))
* remove stateVersion and update inputs ([04a2ea7](https://github.com/misumisumi/nixos-desktop-config/commit/04a2ea7f0949e9c27d391e1eb6c369e27dfb4e0c))
* rename to liveimg and add ssh ([93ee3bb](https://github.com/misumisumi/nixos-desktop-config/commit/93ee3bbd50d77ce90255e383d6ef1d0fae82f366))
* separate gsettings ([16f4e87](https://github.com/misumisumi/nixos-desktop-config/commit/16f4e875b86de3f56d21233c1752409a6a68600d))
* soleus config ([ba38f88](https://github.com/misumisumi/nixos-desktop-config/commit/ba38f88ef1730f3a9de33bb56a3f84a4d7e1314f))
* some fix ([521d8dc](https://github.com/misumisumi/nixos-desktop-config/commit/521d8dc487c2320eeb4487440675e411f237873e))
* **ssh:** remove branching by version ([f08e08b](https://github.com/misumisumi/nixos-desktop-config/commit/f08e08b8c9068001a8f6584627f9047a1688482c))
* test config ([2227a9a](https://github.com/misumisumi/nixos-desktop-config/commit/2227a9a773949a46da1880dd13651a51eeb4bc37))
* typos ([792b16c](https://github.com/misumisumi/nixos-desktop-config/commit/792b16c03dd522cc26cb0d8cf410e92a60c7eb3d))
* virtualisation configs ([5aa22da](https://github.com/misumisumi/nixos-desktop-config/commit/5aa22da2758bac0d9e7dd24096e79592a825e753))
* virtualisation.podman.enableNvidia is deprecated ([f65ba1f](https://github.com/misumisumi/nixos-desktop-config/commit/f65ba1f9a156f6c3da5f5cf7bbf4272746ebdaf5))


### Miscellaneous Chores

* release 2.0.0 ([33015c3](https://github.com/misumisumi/nixos-desktop-config/commit/33015c32babc65f2761ae1c4d04ba9ca77dabb3e))


### Code Refactoring

* include user-wide settings ([ab9baef](https://github.com/misumisumi/nixos-desktop-config/commit/ab9baefba461efa2db563c8edf0fc9823576af40)), closes [#51](https://github.com/misumisumi/nixos-desktop-config/issues/51)

## [1.1.4](https://github.com/misumisumi/nixos-desktop-config/compare/v1.1.3...v1.1.4) (2024-05-12)


### ⚠ BREAKING CHANGES

* include user-wide settings

### Bug Fixes

* remove hm dir ([34779c6](https://github.com/misumisumi/nixos-desktop-config/commit/34779c626f87cb285cf12da620ce165e75a3b377))
* some fix ([12ca362](https://github.com/misumisumi/nixos-desktop-config/commit/12ca362831b7d078100f3ad3ab8f75cb1e467e5d))
* typos ([9286cb5](https://github.com/misumisumi/nixos-desktop-config/commit/9286cb58390c777e86d497f53c96cf0d83ee516c))


### Code Refactoring

* include user-wide settings ([dedf82a](https://github.com/misumisumi/nixos-desktop-config/commit/dedf82a8842265ff28f7654cf7aac9fd61a3d383)), closes [#51](https://github.com/misumisumi/nixos-desktop-config/issues/51)

## [1.1.3](https://github.com/misumisumi/nixos-desktop-config/compare/v1.1.2...v1.1.3) (2024-05-08)


### Bug Fixes

* **libinputs:** fix option name ([941b625](https://github.com/misumisumi/nixos-desktop-config/commit/941b6256040cabe54bf716655e0e4caa5f593b44))
* **network:** fix vlan-tag network ([7234ea6](https://github.com/misumisumi/nixos-desktop-config/commit/7234ea64cd11ffc942159ee02c18679d5d21d862))
* **nvidia-container-toolkit:** rename option to `hardware.nvidia-container-toolkit` ([a7673d3](https://github.com/misumisumi/nixos-desktop-config/commit/a7673d328ab22aaf3624c6d6edc83a9f3ef03ccf))
* remove stateVersion and update inputs ([00a2bae](https://github.com/misumisumi/nixos-desktop-config/commit/00a2bae8010820f8f1138b1af427ae4ddac39201))
* **ssh:** remove branching by version ([562fbdf](https://github.com/misumisumi/nixos-desktop-config/commit/562fbdf62c2022410bc98fd0c7392b8454a8654d))
* test config ([4e4945a](https://github.com/misumisumi/nixos-desktop-config/commit/4e4945a0094e87a3bb8f5595cfdc09cc1781b3ee))

## [1.1.2](https://github.com/misumisumi/nixos-desktop-config/compare/v1.1.1...v1.1.2) (2024-04-22)


### Bug Fixes

* depricate config ([a2a9ce2](https://github.com/misumisumi/nixos-desktop-config/commit/a2a9ce2e614aaa4aaef1b65cab3ef3d1e5a04ddd))

## [1.1.1](https://github.com/misumisumi/nixos-desktop-config/compare/v1.1.0...v1.1.1) (2024-04-13)


### Bug Fixes

* **.nixd.json:** use nixpkgs-fmt ([51b796d](https://github.com/misumisumi/nixos-desktop-config/commit/51b796d2b58a17017c485660a7b443f70be3eae7))
* fix module name ([8aebf9f](https://github.com/misumisumi/nixos-desktop-config/commit/8aebf9f95a7c40858aba679dfd56aed4cdd510ba))

## [1.1.0](https://github.com/misumisumi/nixos-desktop-config/compare/v1.0.1...v1.1.0) (2024-03-29)


### Features

* create default incus config ([a408e8d](https://github.com/misumisumi/nixos-desktop-config/commit/a408e8d013505bb8b9c181418a984abe928f56dc))
* enable nftable for incus ([fd74497](https://github.com/misumisumi/nixos-desktop-config/commit/fd74497085ced848bddd5136faa034f0c251825f))
* fix auto approve and support dependabot ([f565cc7](https://github.com/misumisumi/nixos-desktop-config/commit/f565cc76e300c2138ff9b76c8617ebb030ab6c6e))
* reviewdog support ([ceae2d5](https://github.com/misumisumi/nixos-desktop-config/commit/ceae2d5b450976be575bc9e3e1525b0333eef8e8))
* reviewdog support ([eb2173f](https://github.com/misumisumi/nixos-desktop-config/commit/eb2173f7fb871cec3eb3f19dd87d351431e01fa5))
* 複数のvlanに対応させたbridgeの作成 ([003daec](https://github.com/misumisumi/nixos-desktop-config/commit/003daec0ac02fbd1849611ccd55af66d80552500))


### Bug Fixes

* auto-approve workflow ([91b851a](https://github.com/misumisumi/nixos-desktop-config/commit/91b851a9c7602fe7f7b63400c90d133e99cefc89))
* remove patch of incus ([2c902f9](https://github.com/misumisumi/nixos-desktop-config/commit/2c902f9254417bce7ea645877fc5c6f14833c200))
* virtualisation configs ([a39a35c](https://github.com/misumisumi/nixos-desktop-config/commit/a39a35c415797f94de82cd21ebd289dc839a4d09))
* virtualisation.podman.enableNvidia is deprecated ([6a02819](https://github.com/misumisumi/nixos-desktop-config/commit/6a028192ac12d6a1e54b65ed93a6c191ed6cbea3))
