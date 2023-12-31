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
      libsForQt5.dolphin

      ranger
      libnotify
      playerctl
      pamixer
      brightnessctl
      wofi
      grimblast

      # TODO: Icons
      tela-icon-theme

      # WARNING: High memory/cpu usage. should change unless I use videos
      mpvpaper

      swaybg
    ];
  };
}
