{ ... }:
{
  # Import your home-manager configuration
  home-manager.users.danim = {
    imports = [
      ../home
      ../home/danim/home.nix
    ];
  };
}
