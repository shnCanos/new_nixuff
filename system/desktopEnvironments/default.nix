{ lib, usePlasma, useHyprland, pkgs, ... }: {
  imports = [ ./hyprland.nix ./plasma.nix ];
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    layout = "us";
    xkbVariant = "";
  };
}
