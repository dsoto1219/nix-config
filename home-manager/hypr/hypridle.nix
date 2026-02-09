{ ... }:
{
  services.hypridle.enable = true;
  xdg.configFile.hypridle = {
    source = ./hypridle.conf;
    target = "hypr/hypridle.conf";
  };
}

