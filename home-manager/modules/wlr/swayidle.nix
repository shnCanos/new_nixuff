{ pkgs, useSway, useHyprland, ... }: {
  services.swayidle = {
    enable = useSway || useHyprland;
    events = [{
      event = "before-sleep";
      command = "${pkgs.swaylock}/bin/swaylock -fF";
    }];

    timeouts = [
      {
        timeout = 60;
        command = "${pkgs.brightnessctl}/bin/brightnessctl set 1%";
      }
      {
        timeout = 120;
        command = "${pkgs.swaylock}/bin/swaylock -fF";
      }
      {
        timeout = 300;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
}
