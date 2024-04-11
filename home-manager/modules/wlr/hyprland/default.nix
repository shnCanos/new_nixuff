{ config, lib, useHyprland, wallpaper, configName, isDesktop, ... }:

let
  mkRule = lib.foldlAttrs (acc: app: rule: acc ++ [ "${rule},^(${app})$" ]) [ ];
  global = import ../globals.nix;
  vars = global.vars;

in {
  imports = [ /*./dunst.nix */ ./binds.nix ./swaync.nix];

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
          "fcitx5"
          (global.funcs.applyWallpaper wallpaper)

          "[workspace 1 silent] firefox"
          "[workspace 3 silent] kitty"
        ];

        monitor = [
          "desc:ASUSTek COMPUTER INC VG248 K4LMQS112536,highrr,auto,1,transform,3"
          # "desc:BOE 0x08D5,highrr,auto,1"
          ",highrr,auto,1"
        ];

        env = [
          "WLR_DRM_NO_ATOMIC,1"
          "NIXOS_OZONE_WL,1"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        ];

        input = {
          kb_layout = "us,pt";
          # use fcitx5 instead
          # kb_options = "grp:win_space_toggle";
          touchpad.natural_scroll = lib.mkIf (!isDesktop) true;
          # follow_mouse = "2"; # Click windows to focus them
          accel_profile = lib.mkIf (isDesktop) "flat";
        };

        bezier = [
          "easeOutBack,0.34,1.56,0.64,1"
          "easeOutQuart,0.25,1,0.5,1"
          "easeInOutExpo,0.87,0,0.13,1"
          "easeInOutBack,0.68,-0.6,0.32,1.6"
          "easeOutQuint,0.22,1,0.36,1"
        ];
        animation = [
          "workspaces,1,4,default,slidefade"
          "windowsIn,1,4,easeOutBack,slide"
          "windowsOut,1,4,easeInOutBack,slide"
          "windowsMove,1,3,easeOutBack,slide"
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
            # Whenever someone went online,
            # This would bring me to the 5th desktop
            # steam = "workspace 5";
          };

      };
    };
  };
}
