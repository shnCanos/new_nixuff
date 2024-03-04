{ lib, usePlasma, ... }: {
  config = lib.mkIf (usePlasma) {
    services.xserver = {
      # PLASMA 6!
      desktopManager.plasma6.enable = true;
      displayManager.defaultSession = "plasma";
    };
  };
}
