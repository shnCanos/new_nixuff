{ lib, pkgs, useHyprland, configName, ... }: {
  config = lib.mkIf (useHyprland) {

    home.packages = with pkgs; [ dunst libnotify playerctl brillo rofi ];

    services.gammastep = {
      enable = true;
      dawnTime = "7:00-9:00";
      duskTime = "17:30-18:00";
      temperature = {
        day = 4000;
        night = 2000;
      };
      tray = true;
    };

    programs.wofi = {
      enable = true;
      settings = {
        width = 600;
        height = 300;
        location = "center";
        show = "drun";
        prompt = "Search...";
        filter_rate = 100;
        allow_markup = true;
        no_actions = true;
        halign = "fill";
        orientation = "vertical";
        content_halign = "fill";
        insensitive = true;
        allow_images = true;
        image_size = 40;
        gtk_dark = true;
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        general.allow_tearing = true;

        exec-once = [ "nm-applet" "blueman-applet" "gammastep" ];

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
          accel_profile = lib.mkIf (configName == "main") "flat";
        };
        gestures = {
          workspace_swipe = true;
          workspace_swipe_forever = true;
        };

        misc = {
          disable_hyprland_logo = false;
          disable_autoreload = false; # NOTE: For now
        };

        bind = let
          getStringBetween = lowerBound: higherBound: stringGen:
            (builtins.genList
              (x: let ws = toString (x + lowerBound); in (stringGen ws))
              higherBound);

          terminal = "kitty";
          mod1 = "SUPER";
          mod2 = "ALT";
          launcher = "wofi";
        in [
          "${mod1},RETURN,exec,${terminal}"
          "${mod1},D,exec,${launcher}"
          "${mod1}_SHIFT,N,exec,firefox -p frozsnow"
          "${mod1},E,exec,dolphin"

          "${mod1},Q,killactive"
          "${mod1},F,fullscreen"
          "${mod1}_SHIFT,E,exit"
          "${mod2},F,togglefloating"

          "${mod1}_CTRL,H,workspace,-1"
          "${mod1}_CTRL,L,workspace,+1"
          "${mod1}_CTRL,K,workspace,-3"
          "${mod1}_CTRL,J,workspace,+3"

          "${mod1}_SHIFT_CTRL,H,movetoworkspace,-1"
          "${mod1}_SHIFT_CTRL,L,movetoworkspace,+1"
          "${mod1}_SHIFT_CTRL,K,movetoworkspace,-3"
          "${mod1}_SHIFT_CTRL,J,movetoworkspace,+3"
        ] ++
        #WIN+NUMWORKSPACESHORTCUTS
        (getStringBetween 1 9 (ws: "${mod1},${ws},workspace,${ws}")) ++
        #WIN+SHIFT+NUMMOVETOWORKSPACESHORTCUTS
        (getStringBetween 1 9 (ws: "${mod1}SHIFT,${ws},movetoworkspace,${ws}"))
        ++ [
          "${mod1},R,togglesplit"
          "${mod1},G,togglegroup"
          "${mod1},P,pseudo"
          "${mod1}SHIFT,R,resizeactive"

          #CHANGEFOCUS
          "${mod1},h,movefocus,l"
          "${mod1},l,movefocus,r"
          "${mod1},k,movefocus,u"
          "${mod1},j,movefocus,d"

          "${mod2}_SHIFT,S,movetoworkspace,special"

          # TODO: check how well these work
          ", XF86AudioPlay, exec, playerctl play-pause" # WORKS
          ", XF86AudioPrev, exec, playerctl previous" # WORKS
          ", XF86AudioNext, exec, playerctl next" # WORKS
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" # WORKS
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle" # WORKS
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+" # WORKS
          ", XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-" # WORKS
          ", XF86MonBrightnessUp, exec, brillo -q -u 300000 -A 5" # DOES NOT WORK
          ", XF86MonBrightnessDown, exec, brillo -q -u 300000 -U 5" # DOES NOT WORK
        ];
      };
    };
  };
}
