{ config, lib, pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    plymouth = {
      # Stylix styles this?
      enable = true;
      theme = "colorful_loop";
      themePackages = [
        (pkgs.adi1090x-plymouth-themes.override {
          selected_themes = [ "${config.boot.plymouth.theme}" ];
        })
      ];
    };
  };
}
