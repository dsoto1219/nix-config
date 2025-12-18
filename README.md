# My Nix Configurations

This repository tracks configurations for NixOS and Home Manager for me on both my Lenovo Thinkbook and for Nixos on WSL.

To replicate NixOS environments, clone this repository and run `sudo nixos-rebuild switch --flake .#[hostname for system]`. To install home-manager, run `nix shell nixpkgs#home-manager`.
