{ pkgs, ... }:
{
  home.packages = with pkgs; [ rclone ];

  systemd.user.services.rclonemount-onedrive = let 
    remote-name = "remote";
    directory = "OneDrive";
  in {
    Unit = {
      Description = "Autostart for rclone filesystem mounting.";
      After = [ "network-online.target" ];
    };
    Service = {
      Type = "notify";
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %h/${directory}/";
      ExecStart = "${pkgs.rclone}/bin/rclone --vfs-cache-mode writes --verbose --ignore-checksum mount ${remote-name}: %h/${directory}";
      ExecStop="/run/wrappers/bin/fusermount -u --verbose %h/${directory}/%i";
    };
    Install.WantedBy = [ "default.target" ];
  };
}
