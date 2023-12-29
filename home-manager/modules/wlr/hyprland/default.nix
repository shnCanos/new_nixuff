{ lib, useHyprland, wallpaper, configName, ... }:

let
  getStringBetween = lowerBound: higherBound: stringGen:
    (builtins.genList (x: let ws = toString (x + lowerBound); in (stringGen ws))
      higherBound);

  mkRule = lib.foldlAttrs (acc: app: rule: acc ++ [ "${rule},^(${app})$" ]) [ ];
in {
  config = lib.mkIf (useHyprland) {
    wayland.windowManager.hyprland = {
      # TODO: Add actual color to the tabs
      enable = true;
      settings = {
        general.allow_tearing = true;

        exec-once = let
          videoWallpaper = ''
            mpvpaper '*' ${wallpaper} -o "loop=yes"
          '';
          normalWallpaper = ''
            swaybg -i ${wallpaper} -m fill
          '';
        in [
          "nm-applet"
          "blueman-applet"
          "gammastep"
          "waybar"
          "swayidle"
          normalWallpaper
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
          touchpad.natural_scroll = true;
          follow_mouse = "2"; # Click windows to focus them
          accel_profile = lib.mkIf (configName == "main") "flat";
        };

        animation = [ "workspaces,1,10,default,fade" ];

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
            blueman = "float";
            discord = "workspace 2";
            steam = "workspace 5";
          };

        bindm = [
          "SUPER,mouse:272,movewindow"
          "SUPER,mouse:273,resizewindow"
          # SUPER_ALT for touchpad
          "SUPER_ALT,mouse:272,resizewindow"
        ];

        bind = let
          mod1 = "SUPER";
          mod2 = "ALT";
          terminal = "kitty";
          launcher = "wofi";
          lock = "swaylock -fF";
        in [
          "${mod1},RETURN,exec,${terminal}"
          "${mod1},D,exec,${launcher}"
          "${mod1}_SHIFT,N,exec,firefox -p frozsnow"
          "${mod1},E,exec,dolphin"
          "${mod1}_SHIFT,L,exec,${lock}"
          "${mod1}_SHIFT,S,exec,grimblast --notify copy area"

          "${mod1},Q,killactive"
          "${mod1},F,fullscreen"
          "${mod1}_SHIFT,E,exit"
          "${mod2},F,togglefloating"

          "${mod1}_CTRL,H,workspace,-1"
          "${mod1}_CTRL,L,workspace,+1"
          "${mod1}_CTRL,K,workspace,-3"
          "${mod1}_CTRL,J,workspace,+3"

          # GROUPD
          "${mod1},G,togglegroup"
          "${mod1}_SHIFT,G,lockactivegroup"
          "ALT,TAB,changegroupactive,f"
          "ALT_SHIFT,TAB,changegroupactive,b"

          "${mod1}_SHIFT_CTRL,H,movetoworkspace,-1"
          "${mod1}_SHIFT_CTRL,L,movetoworkspace,+1"
          "${mod1}_SHIFT_CTRL,K,movetoworkspace,-3"
          "${mod1}_SHIFT_CTRL,J,movetoworkspace,+3"
          "${mod1},R,togglesplit"
          "${mod1},P,pseudo"
          "${mod1}SHIFT,R,resizeactive"

          #CHANGEFOCUS
          "${mod1},h,movefocus,l"
          "${mod1},l,movefocus,r"
          "${mod1},k,movefocus,u"
          "${mod1},j,movefocus,d"

          "${mod2}_SHIFT,S,movetoworkspace,special"
        ] ++
        # WIN+NUM WORKSPACESHORTCUTS
        (getStringBetween 1 9 (ws: "${mod1},${ws},workspace,${ws}")) ++
        # WIN+SHIFT+NUM MOVETOWORKSPACESHORTCUTS
        (getStringBetween 1 9 (ws: "${mod1}SHIFT,${ws},movetoworkspace,${ws}"))
        ++ [
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-"
          ", XF86MonBrightnessUp, exec, brightnessctl set 2%+"
          ", XF86MonBrightnessDown, exec, brightnessctl set 2%-"
        ];
      };
    };
  };
}
