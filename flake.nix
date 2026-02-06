{
  description = "NixOS config for dsoto1219's Thinkbook";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://nixpkgs-python.cachix.org"
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

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
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";

    # nixvim
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nixos-wsl,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs-unstable.legacyPackages.${system};
  in {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = import ./pkgs nixpkgs.legacyPackages.${system};
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = nixpkgs.legacyPackages.${system}.alejandra;
    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      "thinkbook" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        # > Our nixos configuration files <
        modules = [
          ./nixos/common/default.nix
          ./nixos/common/hardware/common-drivers.nix
          ./nixos/common/hardware/tablets.nix
          ./nixos/hosts/thinkbook/fingerprint.nix
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
        ];
      };
      "nixos@nixos" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./home-manager/home.nix
          ./home-manager/users/nixos.nix
        ];
      };
    };
  };
}
