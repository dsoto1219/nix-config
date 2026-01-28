# Single line enabling onedrive, adding like this for modularity's sake
{ pkgs, ... }:
{
  services.onedrive.enable = true;

  # Enable onedriver for filesystem
  environment.systemPackages = with pkgs; [
    onedriver
  ];
}
