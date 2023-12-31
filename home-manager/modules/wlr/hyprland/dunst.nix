{ config, pkgs, useHyprland, ... }:

{
  services.dunst = {
    enable = useHyprland;
    settings = {
      global = {
        browser = "${pkgs.firefox}/bin/firefox -new-tab";
        dmenu = "${pkgs.rofi}/bin/rofi -dmenu";
        follow = "mouse";
        format = "<b>%s</b>\\n%b";
        frame_width = 2;
        geometry = "500x5-5+30";
        horizontal_padding = 8;
        icon_position = "off";
        line_height = 0;
        markup = "full";
        padding = 8;
        separator_height = 2;
        transparency = 10;
        word_wrap = true;
        layer = "overlay";
      };

      iconTheme.name = "Tela-Dark";

      urgency_low.timeout = 10;

      urgency_normal.timeout = 15;

      urgency_critical.timeout = 0;
    };
  };
}
