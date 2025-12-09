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
    # -p adds '/' to the end of directories
    la = "ls -ap --group-directories-first --color=auto";
    ll = "ls -lap --group-directories-first --color=auto";
  };
}
