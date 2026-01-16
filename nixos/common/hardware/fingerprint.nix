{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    open-fprintd
    libfprint libfprint-tod
  ];

  security.pam.services.login.fprintAuth = true;
}
