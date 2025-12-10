# Desktop-related configuration options (mainly hyprland)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # Use Hyprland
  programs.hyprland = let
    system = pkgs.stdenv.hostPlatform.system;
  in {
    enable = true;
    # For flake:
    package = inputs.hyprland.packages."${system}".hyprland; 
    # Use Universal Wayland Session Manager---recommended way of launching Hyprland, as it neatly integrates with systemd.
    # withUWSM = true; 
  };

  # Might need to do this in order for hyprpolkitagent to work
  security.polkit.enable = true;

  # Login Manager: ReGreet
  programs.regreet.enable = true;
  # Needs greetd to be setup
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.hyprland}/bin/hyprland";
      };
    };
  };

  # Optional: hint electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
