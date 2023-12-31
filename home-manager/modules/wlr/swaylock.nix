{ pkgs, useSway, useHyprland, ... }: {
  programs.swaylock = {
    enable = useSway || useHyprland;
    package = pkgs.swaylock-effects;

    settings = {
      effect-blur = "20x3";
      fade-in = 0.5;
    };
  };
}
