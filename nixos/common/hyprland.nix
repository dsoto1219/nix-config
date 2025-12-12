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
  services.greetd.enable = true;
  # Create the hyprland configuration file that the regreet docs tell you to
  environment.etc."greetd/hyprland.conf".text = ''
    # Minimal config just for the greeter
    exec-once = regreet; hyprctl dispatch exit
    misc {
      disable_hyprland_logo = true
      disable_splash_rendering = true
      disable_hyprland_guiuilts_check = true
    }
  '';
  services.greetd.settings = rec {
    default_session = {
      command = "${pkgs.hyprland}/bin/Hyprland --config /etc/greetd/hyprland.conf";
      user = "greeter";
    };
  };

  # Optional: hint electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
