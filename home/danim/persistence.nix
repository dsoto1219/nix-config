{ ... }:
{
  home.persistence."/persistent" = {
    directories = [
      "Dev"
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      # "VirtualBox VMs"
      { directory = ".gnupg"; mode = "0700"; }
      { directory = ".ssh"; mode = "0700"; }
      { directory = ".nixops"; mode = "0700"; }
      { directory = ".local/share/keyrings"; mode = "0700"; }
      ".local/share/direnv"
    ];
    files = [
      ".screenrc"
    ];
  };
}
