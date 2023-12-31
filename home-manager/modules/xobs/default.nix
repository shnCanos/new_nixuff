{ config, ... }: {
  xdg.desktopEntries.xobs = {
    name = "XOBS: Obs Studio on X11";
    genericName = "Wayland screen sharer";
    exec = config.home.shellAliases.xobs;
    icon = ./obsicon.png;
    terminal = false;
  };
}
