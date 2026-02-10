# Shell configurations shared across all machines.
# I like zsh being the default shell
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.zsh.enable = true; # want zsh to be the default shell

  environment.shells = with pkgs; [ bash zsh ];
}
