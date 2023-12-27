{ inputs, ... }:

{
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
