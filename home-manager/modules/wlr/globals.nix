rec {
  vars = {
    terminal = "kitty";
    launcher = "wofi";
    lock = "swaylock -fF";
    exit = "sway exit ; hyprctl dispatch exit"; # both
    fileManager = "nautilus";
    screenshot = "grimblast --notify copy area";
    otherFirefox = "firefox -p frozsnow";
  };

  funcs = {
    powermenu = { in_corner }:
      "${./powermenu.sh} '${vars.lock}' '${vars.exit}' ${
        if in_corner then "true" else "false"
      }";

    videoWallpaperCommand = wallpaperFile: ''
      mpvpaper '*' ${wallpaperFile} -o "loop=yes"
    '';
    normalWallpaperCommand = wallpaperFile: ''
      swaybg -i ${wallpaperFile} -m fill
    '';

    mkWallpaper = wallpaper:
      if wallpaper.isVideo then
        (funcs.videoWallpaperCommand wallpaper.file)
      else
        (funcs.normalWallpaperCommand wallpaper.file);
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
