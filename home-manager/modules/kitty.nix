{ wallpaper, ... }: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableBashIntegration = true;
    settings = {
      disable_ligatures = "never";
      # removed due to visual glitches
      # background_image = builtins.toString wallpaper;
      # background_image_layout = "scaled";
      # background_tint = "0.996"; # Do they not accept floats?
      # background_opacity = "0.006"; # Do they not accept floats?

      # TAB BAR
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      # <<TAB BAR
    };
  };
}
