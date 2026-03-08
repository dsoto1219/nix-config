{ inputs, pkgs, ... }: {
  imports = [
    # Import home-manager's NixOS module
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      # Import your home-manager configuration
      danim = {
        imports = [
          ../home
          ../home/danim/home.nix
        ];
      };
      nixos = {
        imports = [
          ../home
          ../home/nixos-wsl/home.nix
        ];
      };
    };
  };

  # Install home-manager tool globally
  environment.systemPackages = [ 
    inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.default 
  ];
}
