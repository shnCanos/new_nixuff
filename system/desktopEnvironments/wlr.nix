{ config, lib, pkgs, useHyprland, useSway, usePlasma, ... }:

{
  config = lib.mkIf (useHyprland || useSway) {

    programs.sway = lib.mkIf (useSway) {
      enable = true;
      wrapperFeatures.gtk = true;
    };

    programs.hyprland.enable = useHyprland;

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-wlr ];
      wlr.enable = true;
    };

    security.polkit.enable = true;
    services.dbus.enable = true;
    services.blueman.enable = true;
    programs.nm-applet.enable = true;

    # tlp does not like plasma
    services.tlp.enable = !usePlasma;

    # Unnecessary with sway
    security.pam.services.swaylock = lib.mkIf (useHyprland) { };
  };
}
