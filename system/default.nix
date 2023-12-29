{ inputs, useHyprland, useSway, ... }:

{
  assertions = [{
    assertion = !(useHyprland && useSway);
    message =
      "Sway and Hyprland cannot be enabled at the same time due to differences in the waybar config!";
  }];

  imports = [
    /etc/nixos/hardware-configuration.nix

    ./modules/keyd.nix
    ./modules/boot.nix
    ./modules/vms.nix

    ./boilerplate.nix
    ./apps.nix
    ./fonts.nix

    ./desktopEnvironments
  ];

  programs = {
    dconf.enable = true;
    partition-manager.enable = true;
    steam = {
      enable = true;
      gamescopeSession = { enable = true; };
      remotePlay.openFirewall = true;
    };
    kdeconnect.enable = true;
    java.enable = true;
  };
}
