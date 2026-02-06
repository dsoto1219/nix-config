# Desktop-related configuration options (mainly hyprland)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
  hyprland-pkgs = inputs.hyprland.packages.${system};
in {
  # Add must-have packages from docs
  environment.systemPackages = with pkgs; [ 
    # notification daemon set in home-manager
    wireplumber # pipewire: needed for screensharing
    # qt5-wayland and qt6-wayland should be installed by default
    hyprpolkitagent #  authentication agent
    # nerd fonts, including moto, specified in ./nixos/common/default.nix
    hyprshutdown
  ];

  services.pipewire.enable = true;

  ## ENABLE HYPRLAND ##
  # Docs say that enabling the program enables
  # polkit, xdg-desktop-portal-hyprland,
  # as well as fonts
  programs.hyprland = {
    enable = true;
    # set the flake package
    package = hyprland-pkgs.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = hyprland-pkgs.xdg-desktop-portal-hyprland;
    # Use Universal Wayland Session Manager---recommended way of launching Hyprland, as it neatly integrates with systemd.
    withUWSM = true;
    # xwayland enabled true by default
  };

  services.greetd.enable = true;
  services.greetd.settings = {
    default_session = {
      command = "${hyprland-pkgs.hyprland}/bin/start-hyprland";
      user = "danim";
    };
  };

  # Optional: hint electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
