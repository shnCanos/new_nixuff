{pkgs, ...}: 

{
  systemd.user.services.swaync = {
      Unit = {
        Description = "Sway Notification Center, gtk notification daemon for wayland";
      };

      Service = {
        Type = "simple";
        Restart = "always";
        ExecStart = "${pkgs.swaynotificationcenter}/bin/swaync";
      };

      Install = { wantedBy = [  "default.target" ]; };
  };

  home.packages = [    pkgs.swaynotificationcenter];
}
