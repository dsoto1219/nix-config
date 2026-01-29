{ pkgs, ... }:
{
  home.packages = with pkgs; [ rclone ];

  systemd.user.services.rclone-mount-onedrive = let 
    remote-name = "remote";
    directory = "OneDrive";
  in {
    Unit = {
      Description = "Autostart for rclone filesystem mounting.";
      After = [ "network-online.target" ];
    };
    Service = {
      Type = "notify";
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ~/${directory}/";
      ExecStart = "${pkgs.rclone}/bin/rclone --vfs-cache-mode writes --ignore-checksum mount ${remote-name}: ~/${directory}";
      ExecStop="/run/wrappers/bin/fusermount -u %h/${directory}/%i";
    };
    Install.WantedBy = [ "default.target" ];
  };
}
