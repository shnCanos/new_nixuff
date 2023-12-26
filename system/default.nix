{ ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./utils/keyd.nix
    ./utils/boot.nix
    ./utils/vms.nix
    ./boilerplate.nix
    ./apps.nix
    ./fonts.nix

    # Only plasma, for now
    ./desktopEnvironment/plasma.nix
  ];

  personal.plasma.enable = true;

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
