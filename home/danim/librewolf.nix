{ ... }:
{
  stylix.targets.librewolf.profileNames = [ "danim" ];

  programs.librewolf = {
    enable = true;
    profiles.danim = {};
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
