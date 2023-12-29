{ lib, usePlasma, useHyprland, pkgs, ... }: {
  imports = [ ./wlr.nix ./plasma.nix ];
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    layout = "us";
    xkbVariant = "";
  };
}
