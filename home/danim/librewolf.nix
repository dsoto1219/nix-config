{ pkgs, ... }:
{
  stylix.targets.librewolf.profileNames = [ "danim" ];

  programs.librewolf = {
    enable = true;
    package = pkgs.librewolf.override {
      # See nixpkgs' firefox/wrapper.nix to check which options you can use
      nativeMessagingHosts = [
        # Gnome shell native connector
        pkgs.gnome-browser-connector
        # Tridactyl native connector
        pkgs.tridactyl-native
      ];
    };
    profiles.danim = {
      search = {
        force = true;
        default = "ecosia";
        privateDefault = "ecosia";
        order = ["ecosia" "ddg" "google"];
        engines = {
          ecosia = {
            name = "ecosia";
            urls = [{
              template = "https://ecosia.org/search?q={searchTerms}";}
            ];
            icon = "https://ecosia.org/favicon.ico";
          };
          bing.metaData.hidden = true;
          google.metaData = {
            hidden = true;
            alias = "@g";
          };
        };
    };
    # Enable WebGL, cookies and history
    settings = {
      "webgl.disabled" = false;
      "privacy.resistFingerprinting" = false;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.cookies" = false;
      "network.cookie.lifetimePolicy" = 0;
    };
  };
}
