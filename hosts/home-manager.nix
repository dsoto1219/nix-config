{ inputs, pkgs, ... }: {
  imports = [
    # Import home-manager's NixOS module
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.extraSpecialArgs = { inherit inputs; };

  # Install home-manager tool globally
  environment.systemPackages = [ 
    inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.default 
  ];
}
