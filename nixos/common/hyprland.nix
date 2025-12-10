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
    # nerd fonts, including moto, specified in ./nixos/common/default.nix
  ];

  services.pipewire.enable = true;

  ## ENABLE HYPRLAND ##
  # Docs say that enabling the program enables
  # polkit, xdg-desktop-portal-hyprland,
  # as well as fonts
  programs.hyprland = {
    enable = true;
    # Use Universal Wayland Session Manager---recommended way of launching Hyprland, as it neatly integrates with systemd.
    withUWSM = true; 
    # xwayland enabled true by default
  };

  # Login Manager: ReGreet
  programs.regreet.enable = true;
  # Needs greetd to be setup
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session.command = "${pkgs.hyprland}/bin/Hyprland";
      default_session = initial_session;
    };
  };

  # Optional: hint electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
