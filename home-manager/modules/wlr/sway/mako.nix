{ useSway, ... }: {
  services.mako = {
    enable = useSway;
    anchor = "top-right";
    borderRadius = 10;
    borderSize = 2;
    defaultTimeout = 5000;
    layer = "overlay"; # Appear over fullscreen windows
  };
}
