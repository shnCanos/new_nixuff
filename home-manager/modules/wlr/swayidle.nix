{ pkgs, useSway, useHyprland, wallpaper, ... }: {
  services.swayidle = let
    global = import ./globals.nix wallpaper;
    vars = global.vars;
    lock_command = "${pkgs.swaylock}/bin/${vars.lock}";
  in {
    enable = useSway || useHyprland;

    events = [{
      event = "before-sleep";
      command = "${lock_command}";
    }];

    timeouts = [
      {
        timeout = 180;
        command = "${pkgs.brightnessctl}/bin/brightnessctl set 1%";
      }
      {
        timeout = 300;
        command = "${lock_command} && ${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
}
