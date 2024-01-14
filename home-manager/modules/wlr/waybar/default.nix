{ useSway, useHyprland, wallpaper, ... }:
let
  global = import ../globals.nix;

  current = if (useSway) then "sway" else "hyprland";

  # Pallete
  mkColor = color: icon: ''<span foreground="${color}">${icon}</span>'';
  colors = {
    red = "red";
    brown = "#cfb484";
    orange = "orange";
  };
in {
  programs.waybar = {
    enable = useSway || useHyprland;
    # TODO:
    # Add Apps (maybe)
    # Add media (maybe)
    # Add cliboard manager (maybe)
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [
          "network"
          "backlight"
          "custom/separator2"
          "cpu"
          "memory"
          "custom/separator2"
          "battery"
        ];
        modules-center = [ "${current}/workspaces" ];
        modules-right = [
          "pulseaudio"
          "pulseaudio#microphone"
          "custom/separator"
          "${current}/language"
          "tray"
          "custom/separator"
          "clock"
          "custom/separator"
          "idle_inhibitor"
          "custom/powermenu"
        ];

        "custom/powermenu" = {
          # wofi -D hide_search=true
          format = "  ";
          interval = "once";
          tooltip = true;
          on-click = global.funcs.powermenu {
            in_corner = true;
            inherit useHyprland;
          };
        };

        memory = {
          interval = 3;
          format = "󰭣  {used:0.1f}G";
        };

        backlight = {
          device = "intel_backlight";
          format = "{icon} {percent}%";
          format-icons = [ "󰃞 " "󰃟 " "󰃝 " "󰃠 " ];
        };

        cava = {
          framerate = 30;
          bars = 30;
          format-icons = [ "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
          bar_delimiter = 0;
        };

        network = {
          format = "{ifname}";
          format-wifi = "{icon} {signalStrength}%";
          format-ethernet = "󰈁";
          format-disconnected = "󰤭 ";
          format-icons = [ "󰤫 " "󰤟 " "󰤢 " "󰤥 " "󰤨 " ];
        };

        cpu.format = "  {usage}%";
        cpu.interval = 3;

        "${current}/window" = { "format" = "{app_id}"; };
        "${current}/language" = {
          format = "{}";

          # NOTE: It needs the space for some reason
          format-en = "🇺🇸";
          format-pt = "🇵🇹";
        };
        "${current}/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          on-click = "activate";
          format = "{icon}";
          format-icons = global.workspaces;
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = mkColor colors.brown "󰅶 ";
            deactivated = "󰾪 ";
          };
        };

        tray = {
          icon-size = 13;
          spacing = 10;
        };

        "custom/separator" = {
          format = "  ";
          interval = "once";
          tooltip = false;
        };

        "custom/separator2" = {
          format = "  ";
          interval = "once";
          tooltip = false;
        };

        "pulseaudio#microphone" = {
          format = "{format_source}";
          format-source = " {volume}%";
          format-source-muted = mkColor colors.orange " Muted";
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
          interval = 10;
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = [
            (mkColor colors.red "󰂃")
            (mkColor colors.red "󰁺")
            (mkColor colors.red "󰁻")
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          tooltip = false;
          format-muted = mkColor colors.orange "󰝟 Muted";
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
}
