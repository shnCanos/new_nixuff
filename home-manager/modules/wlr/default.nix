{ lib, pkgs, useHyprland, useSway, ... }:

{
  imports = [
    ./hyprland
    ./sway
    ./waybar

    ./swayidle.nix
    ./swaylock.nix
    ./gammastep.nix

    # TODO: Add better launcher (this one is being used for the power menu)
    ./wofi.nix
  ];

  config = lib.mkIf (useHyprland || useSway) {

    home.packages = with pkgs; [
      # KDE
      okular
      gwenview
      qt5.qtwayland
      # libsForQt5.dolphin

      # GNOME
      gnome.nautilus

      ranger
      libnotify
      playerctl
      pamixer
      brightnessctl
      wofi
      grimblast

      # WARNING: High memory/cpu usage. should change unless I use videos
      mpvpaper

      swaybg
    ];
  };
}
