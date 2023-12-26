{ ... }: {
  imports = [ ./plasma.nix ];

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
  };
}
