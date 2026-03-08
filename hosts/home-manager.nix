{ inputs, pkgs, ... }: {
  home-manager.extraSpecialArgs = { inherit inputs; };

  # Install home-manager tool globally
  environment.systemPackages = [ 
    inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.default 
  ];
}
