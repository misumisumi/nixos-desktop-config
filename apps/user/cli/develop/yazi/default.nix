{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    package =
      let
        jemalloc' = pkgs.rust-jemalloc-sys.override {
          jemalloc = pkgs.jemalloc.override {
            # "libjemalloc.so.2: cannot allocate memory in static TLS block"の回避

            # appがクラッシュする危険性あり
            # https://github.com/jemalloc/jemalloc/blob/6092c980a6d02b34bc7b3ed0c2ad923d0a5d2970/INSTALL.md?plain=1#L273:L280

            # https://github.com/pola-rs/polars/issues/5401#issuecomment-1300998316
            disableInitExecTls = true;
          };
        };
      in
      pkgs.yazi.override {
        yazi-unwrapped = pkgs.yazi-unwrapped.override { rust-jemalloc-sys = jemalloc'; };
      };
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
