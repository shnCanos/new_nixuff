{ wallpaper, useHyprland, ... }:
let
  mod1 = "SUPER";
  mod2 = "ALT";

  global = import ../globals.nix;
  vars = global.vars;

  # This function takes a function with 1 arg and returns a list with every string
  # generated with that arg ranging from lowerBound to upperBound
  getStringBetween = lowerBound: higherBound: stringGen:
    (builtins.genList (x: let ws = toString (x + lowerBound); in (stringGen ws))
      higherBound);
in {

  wayland.windowManager.hyprland.settings = {
    bindm = [
      "SUPER,mouse:272,movewindow"
      "SUPER,mouse:273,resizewindow"
      # SUPER_ALT for touchpad
      "SUPER_ALT,mouse:272,resizewindow"
    ];

    bind = [
      "${mod1},RETURN,exec,${vars.terminal}"
      "${mod1},D,exec,${vars.launcher}"
      "${mod1}_SHIFT,N,exec,${vars.otherFirefox}"
      "${mod1},E,exec,${vars.fileManager}"
      # "${mod1}_SHIFT,L,exec,${vars.lock}"
      "${mod1}_SHIFT,S,exec,${vars.screenshot}"

      "${mod1},Q,killactive"
      "${mod1},F,fullscreen"
      "${mod1}_SHIFT,E,exec,${
        global.funcs.powermenu {
          in_corner = false;
          inherit useHyprland;
        }
      }"
      "${mod2},F,togglefloating"

      "${mod1}_CTRL,H,workspace,-1"
      "${mod1}_CTRL,L,workspace,+1"
      "${mod1}_CTRL,K,workspace,-3"
      "${mod1}_CTRL,J,workspace,+3"

      # GROUP
      "${mod1},G,togglegroup"
      "${mod1}_SHIFT,G,lockactivegroup"
      "ALT,TAB,changegroupactive,f"
      "ALT_SHIFT,TAB,changegroupactive,b"

      "${mod1}_SHIFT_CTRL,H,movetoworkspace,-1"
      "${mod1}_SHIFT_CTRL,L,movetoworkspace,+1"
      "${mod1}_SHIFT_CTRL,K,movetoworkspace,-3"
      "${mod1}_SHIFT_CTRL,J,movetoworkspace,+3"
      "${mod1},R,togglesplit"
      "${mod1},P,pseudo"
      "${mod1}SHIFT,R,resizeactive"

      #CHANGEFOCUS
      "${mod1},h,movefocus,l"
      "${mod1},l,movefocus,r"
      "${mod1},k,movefocus,u"
      "${mod1},j,movefocus,d"
      "${mod1}_SHIFT,h,movewindow,l"
      "${mod1}_SHIFT,l,movewindow,r"
      "${mod1}_SHIFT,k,movewindow,u"
      "${mod1}_SHIFT,j,movewindow,d"

      # Resize
      "${mod2},h,resizeactive,-200 0"
      "${mod2},j,resizeactive,0 200"
      "${mod2},k,resizeactive,0 -200"
      "${mod2},l,resizeactive,200 0"

      "${mod1}_SHIFT,-,movetoworkspace,special"
    ] ++
      # WIN+NUM WORKSPACESHORTCUTS
      (getStringBetween 1 9 (ws: "${mod1},${ws},workspace,${ws}")) ++
      # WIN+SHIFT+NUM MOVETOWORKSPACESHORTCUTS
      (getStringBetween 1 9 (ws: "${mod1}SHIFT,${ws},movetoworkspace,${ws}"))

      ++
      # Weird keys
      [
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
}
