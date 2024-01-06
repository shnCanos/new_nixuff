wallpaper: rec {
  vars = {
    terminal = "kitty";
    launcher = "wofi";
    lock = "swaylock -fF";
    exit = "sway exit ; hyprctl dispatch exit"; # both
    fileManager = "nautilus";
    screenshot = "grimblast --notify copy area";
    otherFirefox = "firefox -p frozsnow";

    videoWallpaper = ''
      mpvpaper '*' ${wallpaper} -o "loop=yes"
    '';
    normalWallpaper = ''
      swaybg -i ${wallpaper} -m fill
    '';
  };

  funcs = {
    powermenu = { in_corner }:
      "${./powermenu.sh} '${vars.lock}' '${vars.exit}' ${
        if in_corner then "true" else "false"
      }";
  };

  workspaces = {
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
}
