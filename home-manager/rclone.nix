{ pkgs, ... }:
{
  home.packages = with pkgs; [ rclone ];

  systemd.user.services.rclonemount-onedrive = let 
    remote-name = "remote";
    directory = "OneDrive";
  in {
    Unit = {
      Description = "rclone mount onedrive";
      After = [ "network-online.target" ];
    };
    Service = {
      Type = "simple";
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %h/${directory}/";
      ExecStart = ''${pkgs.rclone}/bin/rclone mount \
        --config %h/.config/rclone/rclone.conf \
        --cache-dir %h/.cache/rclone/ \
        --vfs-cache-mode writes -vv \
        --vfs-read-chunk-size 4M
        --vfs-read-chunk-streams 16
        --no-checksum --no-modtime --no-seek \
        ${remote-name}: %h/${directory}/
      '';
      ExecStop="/run/wrappers/bin/fusermount -u -vv %h/${directory}/%i";
    };
    Install.WantedBy = [ "default.target" ];
  };
}
