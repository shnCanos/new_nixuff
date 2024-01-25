{ config, ... }: {
  xdg.desktopEntries.xobs = {
    name = "XOBS: Obs on X11";
    genericName = "Discord wayland screen sharer";
    exec = config.home.shellAliases.xobs;
    icon = ./obsicon.png;
    terminal = false;
  };
}
