{ config, lib, pkgs, usePlasma, ... }:

{
  # Setup keyfile
  boot.initrd.secrets = { "/crypto_keyfile.bin" = null; };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-566064f4-23d7-43f9-ae89-58725ded8228".device =
    "/dev/disk/by-uuid/566064f4-23d7-43f9-ae89-58725ded8228";
  boot.initrd.luks.devices."luks-566064f4-23d7-43f9-ae89-58725ded8228".keyFile =
    "/crypto_keyfile.bin";

  networking.hostName = "canos-ideapad-laptop";

  # Fingerprint (Probably not going to do anything, however)
  # services.fprintd.enable = true;
  # services.fprintd.tod.enable = true;
  # services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;

  # Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  # hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  # services.blueman.enable = true;

  # tlp does not like plasma
  services.tlp.enable = !usePlasma;

  services.throttled.enable =
    true; # Workaround for intel cpu issues, or something?

  # To make tpl work in newer thinkpads (might not be needed)
  # boot = {
  #   kernelModules = [ "acpi_call" ];
  #   extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
  # };

  # services.samba-wsdd = {
  #   # make shares visible for Windows clients
  #   enable = true;
  #   openFirewall = true;
  # };
  # services.samba = {
  #   enable = true;
  #   # securityType = "user";
  #   # extraConfig = ''
  #   #   security = user 
  #   # '';
  #   shares = {
  #     public = {
  #       path = "/home/canos/Public";
  #       browseable = "yes";
  #       "read only" = "no";
  #       "guest ok" = "yes";
  #       "create mask" = "0644";
  #       "directory mask" = "0755";
  #       "force user" = "canos";
  #     };
  #     # private = {
  #     #   path = "/mnt/Shares/Private";
  #     #   browseable = "yes";
  #     #   "read only" = "no";
  #     #   "guest ok" = "no";
  #     #   "create mask" = "0644";
  #     #   "directory mask" = "0755";
  #     # };
  #   };
  # };
  #
  # networking.firewall.enable = true;
  # networking.firewall.allowPing = true;
  # services.samba.openFirewall = true;
  # services.gvfs.enable = true;
}
