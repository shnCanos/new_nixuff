{ lib, usePlasma, ... }: {
  config = lib.mkIf (usePlasma) {
    services.desktopManager.plasma6.enable = true;
    services.xserver = {
      # PLASMA 6!
      displayManager.defaultSession = "plasma";
    };
  };
}
