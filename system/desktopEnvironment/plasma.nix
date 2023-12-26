{ config, lib, ... }:

let cfg = config.personal.plasma;
in with lib; {
  options = {
    personal.plasma = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;

      displayManager = {
        defaultSession = "plasmawayland";
        gdm.enable = true; # GDM because of lightdm issues or something
      };

      desktopManager.plasma5.enable = true;
      layout = "us";
      xkbVariant = "";
    };
  };
}
