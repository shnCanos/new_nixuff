{ lib, usePlasma, ... }: {
  config = lib.mkIf (usePlasma) {
    services.xserver = {
      desktopManager.plasma5.enable = true;
      displayManager.defaultSession = "plasmawayland";
    };
  };
}
