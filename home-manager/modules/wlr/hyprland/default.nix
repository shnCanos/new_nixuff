{ config, lib, useHyprland, wallpaper, configName, isDesktop, ... }:

let
  mkRule = lib.foldlAttrs (acc: app: rule: acc ++ [ "${rule},^(${app})$" ]) [ ];
  global = (import ../globals.nix) wallpaper;
  vars = global.vars;

in {
  imports = [ ./dunst.nix ./binds.nix ];

  config = lib.mkIf (useHyprland) {
    wayland.windowManager.hyprland = {
      # TODO: Add actual color to the tabs
      enable = true;
      settings = {
        general = {
          allow_tearing = true;
          gaps_in = 0;
          gaps_out = 0;
        };

        exec-once = [
          "nm-applet"
          "blueman-applet"
          "gammastep"
          "waybar"
          "swayidle"
          vars.normalWallpaper
        ];

        monitor = [ ",highrr,auto,1" ];

        env = [
          "WLR_DRM_NO_ATOMIC,1"
          "NIXOS_OZONE_WL,1"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        ];

        input = {
          kb_layout = "us,pt";
          kb_options = "grp:win_space_toggle";
          touchpad.natural_scroll = lib.mkIf (!isDesktop) true;
          # follow_mouse = "2"; # Click windows to focus them
          accel_profile = lib.mkIf (isDesktop) "flat";
        };

        bezier = [
          "easeOutBack,0.34,1.56,0.64,1"
          "easeOutQuart,0.25,1,0.5,1"
          "easeInOutExpo,0.87,0,0.13,1"
        ];
        animation = [
          "workspaces,1,4,default,slidefade"
          "windowsIn,1,4,easeOutBack,slide"
          "windowsOut,1,4,easeOutBack,slide"
          "windowsMove,1,2,easeOutQuart,slide"
        ];

        gestures = {
          workspace_swipe = true;
          workspace_swipe_forever = true;
        };

        misc = {
          disable_hyprland_logo = true;
          disable_autoreload = false; # NOTE: For now
        };

        windowrule = mkRule
          # How to set rules:
          # app = rule;
          {
            "org.kde.dolphin" = "float";
            "org.gnome.Nautilus" = "float";
            "org.kde.gwenview" = "float";
            blueman = "float";
            discord = "workspace 2";
            steam = "workspace 5";
          };

      };
    };
  };
}
