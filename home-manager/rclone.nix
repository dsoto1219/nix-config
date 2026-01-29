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
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %h/${directory}/";
      ExecStart = "${pkgs.rclone}/bin/rclone --config=%h/.config/rclone/rclone.conf --vfs-cache-mode writes --ignore-checksum mount \"${remote-name}:\" \"%h/${directory}\"";
      ExecStop="/run/wrappers/bin/fusermount -u %h/${directory}/%i";
    };
    Install.WantedBy = [ "default.target" ];
  };
}
