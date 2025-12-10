# Common configuration options related to drivers or other hardware interactions.
# Note that this file is not imported by default.nix because not all nixos installations
# use this file. In particular, these options are not necessary for nixos-wsl.
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  services.pipewire.pulse.enable = true;

  # Enable battery tools.
  services.upower.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;
}
