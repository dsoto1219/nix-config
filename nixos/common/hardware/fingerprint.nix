{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    libfprint libfprint-tod
  ];

  services.fprintd = {
    enable = true;
    package = pkgs.open-fprintd;
  };

  security.pam.services.login.fprintAuth = true;
}
