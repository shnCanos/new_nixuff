{ config, lib, pkgs, useHyprland, useSway, usePlasma, ... }:

{
  config = lib.mkIf (useHyprland || useSway) {

    programs.sway = lib.mkIf (useSway) {
      enable = true;
      wrapperFeatures = {
        gtk = true;
        base = true;
      };
      extraSessionCommands = ''
        # SDL:
        export SDL_VIDEODRIVER=wayland
        # QT (needs qt5.qtwayland in systemPackages):
        export QT_QPA_PLATFORM=wayland-egl
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
        # Fix for some Java AWT applications (e.g. Android Studio),
        # use this if they aren't displayed properly:
        export _JAVA_AWT_WM_NONREPARENTING=1
      '';
    };

    programs.hyprland.enable = useHyprland;

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
      wlr.enable = true;
    };

    security.polkit.enable = true;
    services.dbus.enable = true;
    services.blueman.enable = true;
    programs.nm-applet.enable = true;

    # Unnecessary with sway
    security.pam.services.swaylock = lib.mkIf (useHyprland) { };

    # Gnome related
    services.gvfs.enable = true; # for nautilus
    environment.systemPackages = with pkgs; [ polkit_gnome ];
    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart =
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
