# Borrowed from [zmre's](https://github.com/zmre/nix-config/blob/main/modules/darwin/pam.nix) config
{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
# This PR should theoretically make this module unnecessary
# Keep an eye out
  let
    cfg = config.security.pam;
    mkSudoTouchIdAuthScript = isEnabled: let
      file = "/etc/pam.d/sudo";
      option = "security.pam.enableCustomSudoTouchIdAuth";
    in
      # sh
      ''
        # Unconditionally remove first. If enabled, we'll add it back. This ensures we update pam_reattach.so.
        if grep '${option}' ${file} > /dev/null; then
          /usr/bin/sed -i "" '/${option}/d' ${file}
        fi
        ${
          if isEnabled
          then
            # sh
            ''
              # Enable sudo Touch ID authentication
              /usr/bin/sed -i "" '2i\
              auth       optional     ${pkgs.pam-reattach}/lib/pam/pam_reattach.so # nix-darwin: ${option}\
              auth       sufficient     pam_tid.so # nix-darwin: ${option}
              ' ${file}

            ''
          else ""
        }
      '';
  in {
    options = {
      security.pam.enableCustomSudoTouchIdAuth = mkEnableOption ''
        Enable sudo authentication with Touch ID
        When enabled, this option adds the following line to /etc/pam.d/sudo:
            auth       optional       /path/to/pam_reattach.so
            auth       sufficient     pam_tid.so
        (Note that macOS resets this file when doing a system update. As such, sudo
        authentication with Touch ID won't work after a system update until the nix-darwin
        configuration is reapplied.)
      '';
    };

    config = {
      system.activationScripts.extraActivation.text =
        # sh
        ''
          # PAM settings
          echo >&2 "setting up pam..."
          ${mkSudoTouchIdAuthScript cfg.enableCustomSudoTouchIdAuth}
        '';
    };
  }
