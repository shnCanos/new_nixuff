{ lib, pkgs, useHyprland, configName, wallpaper, ... }:

let
  # FUNCTIONS 
  getStringBetween = lowerBound: higherBound: stringGen:
    (builtins.genList (x: let ws = toString (x + lowerBound); in (stringGen ws))
      higherBound);

  mkRule = lib.foldlAttrs (acc: app: rule: acc ++ [ "${rule},^(${app})$" ]) [ ];

in {
  config = lib.mkIf (useHyprland) {

    home.packages = with pkgs; [
      dunst
      libnotify
      playerctl
      brillo
      # wl-copy # NOTE: Might not be necessary
      pamixer
      brightnessctl
      wofi
      libsForQt5.dolphin
      grimblast
      # WARNING: High memory/cpu usage. should change unless I use videos
      mpvpaper
      swaybg

      # TODO: Add better launcher
    ];

    services.gammastep = {
      enable = true;
      dawnTime = "7:00-9:00";
      duskTime = "17:30-18:00";
      temperature = {
        day = 4000;
        night = 3000;
      };
      tray = true;
    };

    qt = {
      enable = true;
      platformTheme = "qtct";
      style = {
        package = pkgs.catppuccin-kvantum;
        name = "kvantum";
      };
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

    programs.waybar = {
      enable = true;
      # TODO:
      # Add Apps (maybe)
      # Add media (maybe)
      # Add cliboard manager (maybe)
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 30;
          modules-left = [ "hyprland/workspaces" ];
          modules-center = [ "hyprland/window" ];
          modules-right = [
            "pulseaudio"
            "pulseaudio#microphone"
            "custom/separator"
            "battery"
            "custom/separator"
            "hyprland/language"
            "tray"
            "custom/separator"
            "clock"
          ];

          "hyprland/window" = { "format" = "{}"; };
          "hyprland/language" = {
            format = "{}";

            # NOTE: It needs the space for some reason
            format-en = "🇺🇸";
            format-pt = "🇵🇹";
          };
          "hyprland/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
            on-click = "activate";
            format = "{icon}";
            format-icons = {
              "1" = "󰈹 ";
              "2" = "󰙯 ";
              "3" = " ";
              "4" = "󰣼 ";
              "5" = "󰖺 ";
              "6" = "󰣼 ";
              "7" = " ";
              "8" = "󰎆 ";
              "9" = " ";
            };
          };

          tray = {
            icon-size = 13;
            spacing = 10;
          };

          "custom/separator" = {
            format = "|";
            interval = "once";
            tooltip = false;
          };

          "pulseaudio#microphone" = {
            format = "{format_source}";
            format-source = " {volume}%";
            format-source-muted = " Muted";
            on-click = "pamixer --default-source -t";
            on-scroll-up = "pamixer --default-source -i 5";
            on-scroll-down = "pamixer --default-source -d 5";
            scroll-step = 5;
          };

          clock = {
            format = "{: %R  %d/%m}";
            tooltip-format = ''
              <big>{:%Y %B}</big>
              <tt><small>{calendar}</small></tt>'';
          };

          battery = {
            states = {
              good = 95;
              warning = 30;
              critical = 20;
            };
            format = "{icon} {capacity}%";
            format-charging = " {capacity}%";
            format-plugged = " {capacity}%";
            format-alt = "{time} {icon}";
            format-icons = [ "󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          };

          pulseaudio = {
            format = "{icon} {volume}%";
            tooltip = false;
            format-muted = " Muted";
            on-click = "pamixer -t";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = [ "" "" "" ];
            };
          };
        };
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        general.allow_tearing = true;

        exec-once = let
          videoWallpaper = ''
            mpvpaper '*' ${wallpaper} -o "loop=yes"
          '';
          normalWallpaper = ''
            swaybg -o * -i ${wallpaper} -m fill
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

        animation = [ "workspaces,1,5,default,fade" ];

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
          # ALT for touchpad
          "ALT,mouse:272,resizewindow"
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

          "${mod1}_SHIFT_CTRL,H,movetoworkspace,-1"
          "${mod1}_SHIFT_CTRL,L,movetoworkspace,+1"
          "${mod1}_SHIFT_CTRL,K,movetoworkspace,-3"
          "${mod1}_SHIFT_CTRL,J,movetoworkspace,+3"
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

    services.swayidle = {
      enable = true;
      events = [{
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -fF";
      }];

      timeouts = [
        {
          timeout = 60;
          command = "${pkgs.brightnessctl}/bin/brightnessctl set 1%";
        }
        {
          timeout = 120;
          command =
            "${pkgs.brightnessctl}/bin/brightnessctl set 0% && ${pkgs.swaylock}/bin/swaylock -fF";
        }
        {
          timeout = 300;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
    };

    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;

      settings = {
        effect-blur = "20x3";
        fade-in = 0.5;
      };
    };
  };
}
