wallpaper:

{
  vars = {
    terminal = "kitty";
    launcher = "wofi";
    lock = "swaylock -fF";
    fileManager = "dolphin";
    screenshot = "grimblast --notify copy area";
    videoWallpaper = ''
      mpvpaper '*' ${wallpaper} -o "loop=yes"
    '';
    normalWallpaper = ''
      swaybg -i ${wallpaper} -m fill
    '';
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
