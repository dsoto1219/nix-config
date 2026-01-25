# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory (commented out because I haven't added that directory yet)
  # additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
    libfprint = prev.libfprintd.overrideAttrrs (oldAttrs: {
      postPatch = (oldAttrs.postPatch or "") + ''
        # Add 55a4 goodix device driver
        sed -i 's/\(.*0x5840.*\)/ { .vid = 0x27cd, .pid = 0x55a4 },\n\1/'
          libfprint/drivers/goodixmoc/goodix.c
      '';
    });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
