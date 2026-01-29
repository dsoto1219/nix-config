# Single line enabling onedrive, adding like this for modularity's sake
{ pkgs, ... }:
{
  # Enable onedriver for filesystem
  environment.systemPackages = with pkgs; [
    onedriver
  ];

  services.onedrive = {
    enable = true;
    package = pkgs.onedriver;
  };
}
