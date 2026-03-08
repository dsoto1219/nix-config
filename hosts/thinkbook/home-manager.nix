{ inputs, pkgs, ... }: {
  imports = [
    # Import home-manager's NixOS module
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      # Import your home-manager configuration
      danim = import ../../home/danim/home.nix;
      nixos = import ../../home/nixos/home.nix;
    };
  };

  # Install home-manager tool globally
  environment.systemPackages = [ 
    inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.default 
  ];
}
