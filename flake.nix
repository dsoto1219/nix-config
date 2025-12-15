{
  description = "NixOS config for dsoto1219's Thinkbook";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # NixOS-WSL
    nixos-wsl.url = "github:nix-community/NixOS-WSL";

    # Hyprland input gives us more control over plugins
    hyprland.url = "github:hyprwm/Hyprland";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # nixvim
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = {
    self,
    nixpkgs,
    nixos-wsl,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    hyprland-module = { 
      wayland.windowManager.hyprland = {
        enable = true;
        # set the flake package
        package = inputs.hyprland.packages."${system}".hyprland; 
        portalPackage = inputs.hyprland.packages."${system}".xdg-desktop-portal-hyprland; 
      };
    };
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      "thinkbook" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        # > Our nixos configuration files <
        modules = [
          ./nixos/common/default.nix
          ./nixos/common/hardware/drivers.nix
          ./nixos/hosts/thinkbook/configuration.nix
        ];
      };
      "nixos" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
	modules = [
          nixos-wsl.nixosModules.default # Get WSL modules for this configuration
          ./nixos/common/default.nix
          ./nixos/hosts/nixos-wsl/configuration.nix
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "danim@thinkbook" = home-manager.lib.homeManagerConfiguration {
        # Home-manager requires 'pkgs' instance
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        # > Our main home-manager configuration file <
        modules = [
	  ./home-manager/home.nix
	  ./home-manager/users/danim.nix
	  hyprland-module
	  inputs.nixvim.homeModules.nixvim
	];
      };
      "nixos@nixos" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [
	  ./home-manager/home.nix
	  ./home-manager/users/nixos.nix
	  hyprland-module
	  inputs.nixvim.homeModules.nixvim
	];
      };
    };
  };
}
