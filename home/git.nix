# Git configuration: want this to be the default across systems
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.git.enable = true;
  programs.git.package = pkgs.gitFull;
  programs.git.settings = {
    user.email = "dsotomail1219@gmail.com";
    user.name = "dsoto1219";
    init.defaultBranch = "main";

    credential.helper = "libsecret";
  };
  programs.git.lfs.enable = true;
}
