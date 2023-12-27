{ config, lib, pkgs, useHyprland, ... }:

{
  config = lib.mkIf (useHyprland) {
    programs.hyprland.enable = true;
    # environment.sessionVariables.NIXOS_OZONE_WL = "1";

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-wlr ];
    };

    services.blueman.enable = true;
    programs.nm-applet.enable = true;
  };
}
