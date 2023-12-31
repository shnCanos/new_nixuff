{ useSway, useHyprland, ... }: {
  services.gammastep = {
    enable = useSway || useHyprland;
    dawnTime = "7:00-9:00";
    duskTime = "17:30-18:00";
    temperature = {
      day = 4000;
      night = 3000;
    };
    tray = true;
  };
}
