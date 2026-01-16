{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    open-fprintd
    libfprint libfprint-tod
  ];

  services."06cb-009a-fingerprint-sensor" = {
    enable = true;
    backend = "python-validity";
  };

  security.pam.services.login.fprintAuth = true;
}
