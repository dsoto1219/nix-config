# Git configuration: want this to be the default across systems
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.git.enable = true;
  programs.git.config = {
    user.email = "dsotomail1219@gmail.com";
    user.name = "dsoto1219";
    init.defaultBranch = "main";
  };
}
