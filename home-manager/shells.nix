{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.zsh.enable = true;
  programs.starship.enable = true;

  home.shellAliases = {
    ls = "ls --group-directories-first --color=auto";
    la = "ls -a";
    ll = "ls -la";

    # Alias to get battery life info from command line (assuming upower is enabled)
    bat = "upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E 'state|time to full|percentage'";
  };
}
