# This file defines overlays
{ inputs, ... }: {
  # This one brings our custom packages from the 'pkgs' directory (commented out because I haven't added that directory yet)
  # additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
    onedriver = prev.onedriver.overrideAttrs (
      newAttrs: oldAttrs: {
        version = "0.15.0";
        src = final.pkgs.fetchFromGitHub {
          inherit (oldAttrs.src) owner repo;
          rev = "v${newAttrs.version}";
          hash = "sha256-DCxF52CtA9KAP+yz5Rgzc/nUAXtZwfYAVU7oHREJlRY=";
        };
        # new dependencies hash got from: nixpkgs-update-log
        # https://nixpkgs-update-logs.nix-community.org/onedriver/2026-01-31.log
        vendorHash = "sha256-Ifcmf9AtZnrjgTPQnof/ap0TY19zHVftm5N4JgvbAgs=";
        # Desktop file name changed in:
        # https://github.com/jstaf/onedriver/commit/4377d7562089b7725957e371671e86130322ff54
        postInstall =
          builtins.replaceStrings [ "resources/onedriver.desktop" ] [ "resources/onedriver-launcher.desktop" ]
            oldAttrs.postInstall;
      }
    );
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };
  };
}
