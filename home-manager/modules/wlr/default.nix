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
      meson
      wayland-protocols
      wayland-utils
      wl-clipboard
      wlroots

      # KDE
      okular
      gwenview
      qt5.qtwayland
      qt5ct
      libsForQt5.dolphin

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

    qt = {
      enable = true;
      platformTheme = "qtct";
      # style = {
      #   name = "adwaita-dark";
      #   package = pkgs.adwaita-qt;
      # };
    };
  };
}
