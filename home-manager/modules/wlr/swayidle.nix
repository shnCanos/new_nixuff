{ pkgs, useSway, useHyprland, wallpaper, ... }: {
  services.swayidle = let
    global = import ./globals.nix wallpaper;
    vars = global.vars;
  in {
    enable = useSway || useHyprland;
    events = [{
      event = "before-sleep";
      command = "${vars.lock}";
    }];

    timeouts = [
      {
        timeout = 180;
        command = "${pkgs.brightnessctl}/bin/brightnessctl set 1%";
      }
      {
        timeout = 300;
        command = "${vars.lock} && ${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
}
