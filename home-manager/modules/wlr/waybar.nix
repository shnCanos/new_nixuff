{ ... }: {
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
          format = "  ";
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
}
