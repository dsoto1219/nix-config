{ ... }:
{
  imports = [
    ./monitors.nix
    ./my-programs.nix
    ./autostart.nix
    ./environment-variables.nix
    ./permissions.nix
    ./look-and-feel.nix
    ./input.nix
    ./keybinds.nix
  ];

  # Also include windows and workspaces
  # Can't figure out how to port the new window syntax yet, and
  # I don't want to use the shorthands
  wayland.windowManager.hyprland.extraConfig = builtins.readFile ./windows-and-workspaces.conf;
}
