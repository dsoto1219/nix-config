# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{ inputs, pkgs }: {
  # example = pkgs.callPackage ./example { };
  hypr-kdeconnect-fix = pkgs.callPackage ./hypr-kdeconnect-fix.nix {
    src = inputs.hypr-kdeconnect-fix;
  };
}
