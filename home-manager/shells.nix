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
  };
}
