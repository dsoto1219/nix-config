{ pkgs, ... }:
{
  home.packages = with pkgs; [ onedriver ];

  programs.onedrive = {
    enable = true;
    package = pkgs.onedriver;
  };

  xdg.configFile.onedriver = {
    source = ./onedriver_config.yml
    target = "onedriver/config.yml";
  };
}
