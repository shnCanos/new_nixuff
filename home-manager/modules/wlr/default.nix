{ lib, pkgs, useHyprland, useSway, configName, wallpaper, ... }:

{
  config = lib.mkIf (useHyprland || useSway) {
    imports = [
      ./hyprland
      ./wofi.nix
      ./waybar.nix
      ./swayidle.nix
      ./swaylock.nix
      ./gammastep.nix
    ];

    home.packages = with pkgs; [
      # KDE
      okular
      libsForQt5.dolphin

      ranger
      dunst
      libnotify
      playerctl
      brillo
      # wl-copy # NOTE: Might not be necessary
      pamixer
      brightnessctl
      wofi
      grimblast
      # WARNING: High memory/cpu usage. should change unless I use videos
      mpvpaper
      swaybg

      # TODO: Add better launcher
    ];

    # I give up
    # qt = {
    #   enable = true;
    #   platformTheme = "qtct";
    #   style = {
    #     package = (pkgs.catppuccin-kde.override {
    #       accents = [ "pink" ];
    #       flavour = [ "mocha" ];
    #     });
    #     name = "Catppuccin-Mocha-Pink";
    #   };
    # };
  };
}
