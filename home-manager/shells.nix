{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.zsh.enable = true;
  programs.zsh.autocd = true;
  programs.zsh.completionInit = ''
   autoload -U compinit && compinit
   zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}';
  '';
  programs.starship.enable = true;

  home.shellAliases = {
    ls = "ls --group-directories-first --color=auto";
    la = "ls -a";
    ll = "ls -la";

    # Alias to get battery life info from command line (assuming upower is enabled)
    bat = "upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E 'state|to empty|to full|percentage'";
  };
}
