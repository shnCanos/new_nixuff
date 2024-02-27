{ ... }: {
  imports = [ ./wlr.nix ./plasma.nix ];
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };
}
