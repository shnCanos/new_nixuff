{ lib, config, wallpaper, useSway, configName, ... }:

let
  addWsNumber = lib.foldlAttrs
    (acc: wsNumber: icon: acc // { "${wsNumber}" = "${wsNumber}: ${icon}"; })
    { };

  global = import ../globals.nix wallpaper;

  # I add numbers so it gets ordered
  ws = addWsNumber global.workspaces;
  vars = global.vars;
  wallpaper_command = global.vars.normalWallpaper;
in {
  imports = [ ./mako.nix ];

  config = lib.mkIf (useSway) {
    wayland.windowManager.sway = {
      enable = true;

      config = {
        defaultWorkspace = "workspace number 1";

        output = lib.mkIf (configName == "main") {
          DP-3 = { res = "1920x1080@144Hz"; };
        };

        bars = [ ];

        floating.criteria =
          [ { class = "org.kde.dolphin"; } { class = "blueman"; } ];

        assigns = {
          "${ws."2"}" = [{ class = "^discord$"; }];
          "${ws."5"}" = [{ class = "^steam$"; }];
        };

        focus = {
          followMouse = "yes";
          newWindow = "smart";
        };

        input = {
          "*" = {
            xkb_layout = "us,pt";
            xkb_options = "grp:win_space_toggle";
            accel_profile = lib.mkIf (configName == "main") "flat";
            natural_scroll = lib.mkIf (configName != "main") "enable";
            tap = "enable";
            drag = "enable";
          };
        };

        menu = global.vars.launcher;
        modifier = "Mod4";
        seat."*".hide_cursor = "when-typing enable";
        terminal = global.vars.terminal;
        workspaceAutoBackAndForth = true;
        window = { titlebar = false; };

        startup = [ { command = "waybar"; } { command = "blueman-applet"; } ];

        keybindings = let
          mod1 = config.wayland.windowManager.sway.config.modifier;
          mod2 = if (mod1 == "Mod1") then "Mod4" else "Mod1";
        in {
          "${mod1}+Return" = "exec ${vars.terminal}";
          "${mod1}+d" = "exec ${vars.launcher}";
          # "${mod1}+Shift+l" = "exec ${vars.lock}"; # TODO: Create menu
          "${mod1}+Shift+s" = "exec ${vars.screenshot}";
          "${mod1}+Shift+n" = "exec firefox -p frozsnow";

          "${mod1}+q" = "kill";
          "${mod1}+Shift+c" = "reload";
          "${mod1}+Shift+e" = "exit";
          "${mod1}+f" = "fullscreen";
          "${mod2}+f" = "floating toggle";
          "${mod1}+Shift+minus" = "move scratchpad";
          "${mod1}+minus" = "scratchpad show";
          "${mod1}+Shift+r" = ''mode "resize"'';
          "${mod1}+b" = "splith";
          "${mod1}+v" = "splitv";

          "${mod1}+s" = "layout stacking";
          "${mod1}+e" = "layout toggle split";
          # TODO: move workspaces with super+ctrl
          # TODO: move to workspaces with super+shift+ctrl

          "${mod1}+h" = "fullscreen, focus left,   fullscreen, focus left ";
          "${mod1}+j" = "fullscreen, focus down,   fullscreen, focus down ";
          "${mod1}+k " = "fullscreen, focus up,    fullscreen, focus up ";
          "${mod1}+l" = "fullscreen , focus right, fullscreen, focus right ";
          "${mod1}+Left" = " focus left";
          "${mod1}+Down" = " focus down";
          "${mod1}+Up " = "focus up";
          "${mod1}+Right" = " focus right";
          "${mod1}+Shift+Left" = "move left";
          "${mod1}+Shift+Down" = "move down";
          "${mod1}+Shift+Up " = "move up";
          "${mod1}+Shift+Right" = "move right";
          "${mod1}+Shift+h" = "move left";
          "${mod1}+Shift+j" = "move down";
          "${mod1}+Shift+k " = "move up";
          "${mod1}+Shift+l" = "move right";

          "${mod1}+1" = "workspace ${ws."1"}";
          "${mod1}+2" = "workspace ${ws."2"}";
          "${mod1}+3" = "workspace ${ws."3"}";
          "${mod1}+4" = "workspace ${ws."4"}";
          "${mod1}+5" = "workspace ${ws."5"}";
          "${mod1}+6" = "workspace ${ws."6"}";
          "${mod1}+7" = "workspace ${ws."7"}";
          "${mod1}+8" = "workspace ${ws."8"}";
          "${mod1}+9" = "workspace ${ws."9"}";

          "${mod1}+Shift+1" = "move container to workspace ${ws."1"}";
          "${mod1}+Shift+2" = "move container to workspace ${ws."2"}";
          "${mod1}+Shift+3" = "move container to workspace ${ws."3"}";
          "${mod1}+Shift+4" = "move container to workspace ${ws."4"}";
          "${mod1}+Shift+5" = "move container to workspace ${ws."5"}";
          "${mod1}+Shift+6" = "move container to workspace ${ws."6"}";
          "${mod1}+Shift+7" = "move container to workspace ${ws."7"}";
          "${mod1}+Shift+8" = "move container to workspace ${ws."8"}";
          "${mod1}+Shift+9" = "move container to workspace ${ws."9"}";

          "XF86AudioPlay" = "exec playerctl play-pause";
          "XF86AudioPrev" = "exec playerctl previous";
          "XF86AudioNext" = "exec playerctl next";
          "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioMicMute" =
            "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          "XF86AudioRaiseVolume" =
            "exec wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+";
          "XF86AudioLowerVolume" =
            "exec wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-";
          "XF86MonBrightnessUp" = "exec brightnessctl set 2%+";
          "XF86MonBrightnessDown" = "exec brightnessctl set 2%-";
        };
      };
    };
  };
}
