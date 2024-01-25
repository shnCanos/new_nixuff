rec {
  vars = {
    terminal = "kitty";
    launcher = "wofi";
    lock = "swaylock -fF";
    fileManager = "nautilus";
    screenshot = "grimblast --notify copy area";
    otherFirefox = "firefox -p frozsnow";

    # For powermenu
    blackScreen = "brightnessctl set 0";

    restoreBrightness = "brightnessctl --restore";

    exit = {
      hyprland = "hyprctl dispatch exit";
      sway = "sway exit"; # untested
    };
  };

  funcs = {
    powermenu = { in_corner, useHyprland }:
      let
        exitCommand =
          if useHyprland then vars.exit.hyprland else vars.exit.sway;

        cornerBool = if in_corner then "true" else "false";

      in "${
        ./powermenu.sh
      } '${vars.lock}' '${exitCommand}' ${cornerBool} '${vars.blackScreen}' '${vars.restoreBrightness}'";

    videoWallpaperCommand = wallpaperFile: ''
      mpvpaper '*' ${wallpaperFile} -o "loop=yes"
    '';
    normalWallpaperCommand = wallpaperFile: ''
      swaybg -i ${wallpaperFile} -m fill
    '';

    applyWallpaper = { file, isVideo }:
      if isVideo then
        (funcs.videoWallpaperCommand file)
      else
        (funcs.normalWallpaperCommand file);
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
