# Assign long press of space to SHIFT
{ pkgs, ... }:
{
  environment.etc."dual-function-keys/config.yaml".text = ''
    MAPPINGS:
      - KEY: KEY_SPACE
        TAP: KEY_SPACE
        HOLD: KEY_LEFTSHIFT
        HOLD_START: BEFORE_CONSUME_OR_RELEASE
  '';
  services.interception-tools = {
    enable = true;
    udevmonConfig = ''
      - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.dual-function-keys}/bin/dual-function-keys -c /etc/dual-function-keys/config.yaml | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
        DEVICE:
          EVENTS:
            EV_KEY: [KEY_ENTER]
    '';
    plugins = [ pkgs.interception-tools-plugins.dual-function-keys ];
  };
}
