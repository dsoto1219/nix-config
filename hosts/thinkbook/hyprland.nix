# Desktop-related configuration options (mainly hyprland)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # Add must-have packages from docs
  environment.systemPackages = with pkgs; [ 
    # notification daemon set in home-manager
    wireplumber # pipewire: needed for screensharing
    # qt5-wayland and qt6-wayland should be installed by default
    hyprpolkitagent #  authentication agent
  ];

  services.pipewire.enable = true;

  ## ENABLE HYPRLAND ##
  # Docs say that enabling the program enables
  # polkit, xdg-desktop-portal-hyprland,
  # as well as fonts
  programs.hyprland = {
    enable = true;
    # set the flake package
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
