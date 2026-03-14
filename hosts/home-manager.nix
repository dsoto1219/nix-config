{ inputs, pkgs, ... }: 
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  # home-manager.useGlobalPkgs = true; # Not set: conflicts with nixpkgs options set in default.nix
  home-manager.useUserPackages = true;

  home-manager.extraSpecialArgs = { inherit inputs; };

  # Install home-manager tool globally
  environment.systemPackages = [ 
    inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.default 
  ];
}
