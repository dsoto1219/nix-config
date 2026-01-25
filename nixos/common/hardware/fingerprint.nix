{ pkgs, ... }:
{
  services.fprintd = {
    enable = true;
    tod.enable = true;
    tod.driver = pkgs.libfprint-2-tod1-goodix-55a4;
  };

  security.pam.services.login.fprintAuth = true;
}
